#!/usr/bin/env python3
import socket
import os
import sys
import json
import threading
import re
import select  # <--- Essential for interactive sessions

# Configuration
REAL_SOCKET_PATH = f"/run/user/{os.getuid()}/podman/podman.sock"
PROXY_SOCKET_PATH = sys.argv[1] if len(sys.argv) > 1 else "podman-proxy.sock"
ALLOWED_DIR = os.path.abspath(sys.argv[2]) if len(sys.argv) > 2 else os.getcwd()

# Pre-compile regex for performance
CREATE_ENDPOINT_RE = re.compile(rb"POST .*/containers/create")


def validate_path(path):
    """Returns True if path is safe (inside ALLOWED_DIR), False otherwise."""
    if not path.startswith("/") and not path.startswith("."):
        return True  # Named volume

    abs_path = os.path.abspath(path)
    if abs_path == ALLOWED_DIR or abs_path.startswith(os.path.join(ALLOWED_DIR, "")):
        return True

    print(f"[BLOCKED] Path outside sandbox: {abs_path}", file=sys.stderr)
    return False


def inspect_json_body(body_bytes):
    try:
        data = json.loads(body_bytes)
    except json.JSONDecodeError:
        return False

    # 1. Check Docker-style "HostConfig.Binds"
    host_config = data.get("HostConfig", {})
    if host_config:
        binds = host_config.get("Binds", [])
        if binds:
            for bind in binds:
                host_path = bind.split(":")[0]
                if not validate_path(host_path):
                    return False

        mounts = host_config.get("Mounts", [])
        for mount in mounts:
            if mount.get("Type") == "bind":
                if not validate_path(mount.get("Source", "")):
                    return False

    # 2. Check Libpod-style "mounts"
    libpod_mounts = data.get("mounts", [])
    for mount in libpod_mounts:
        if mount.get("type") == "bind":
            if not validate_path(mount.get("source", "")):
                return False

    return True


def handle_client(client_sock):
    upstream_sock = None
    try:
        upstream_sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        upstream_sock.connect(REAL_SOCKET_PATH)
    except Exception as e:
        print(f"Error connecting to Podman: {e}", file=sys.stderr)
        client_sock.close()
        return

    # READ REQUEST HEADERS
    request_data = b""
    header_end = -1

    # Peek at headers to decide logic
    while True:
        chunk = client_sock.recv(4096)
        if not chunk:
            break
        request_data += chunk
        header_end = request_data.find(b"\r\n\r\n")
        if header_end != -1:
            break

    if header_end == -1:
        client_sock.close()
        upstream_sock.close()
        return

    headers_raw = request_data[:header_end]
    body_start = request_data[header_end + 4 :]
    first_line = headers_raw.split(b"\r\n")[0].decode("utf-8", errors="ignore")

    # print(f"REQ: {first_line}", file=sys.stderr)

    # Force Connection: close (Disables Keep-Alive to ensure we inspect every request)
    headers_str = headers_raw.decode("utf-8", errors="ignore")
    if "Connection: keep-alive" in headers_str:
        headers_str = headers_str.replace("Connection: keep-alive", "Connection: close")
    elif "Connection: close" not in headers_str:
        headers_str += "\r\nConnection: close"

    headers_final = headers_str.encode("utf-8")

    # INSPECTION LOGIC
    if CREATE_ENDPOINT_RE.match(first_line.encode("utf-8")):
        # Get Content-Length
        content_length = 0
        match = re.search(r"Content-Length:\s*(\d+)", headers_str, re.IGNORECASE)
        if match:
            content_length = int(match.group(1))

        # Read remainder of body if needed
        while len(body_start) < content_length:
            chunk = client_sock.recv(4096)
            if not chunk:
                break
            body_start += chunk

        if not inspect_json_body(body_start):
            print(f"[GUARD] Blocked illegal mount in: {first_line}", file=sys.stderr)
            resp = b'HTTP/1.1 403 Forbidden\r\nContent-Type: application/json\r\n\r\n{"message": "Sandbox Blocked: Volume mount outside project root forbidden."}\r\n'
            client_sock.sendall(resp)
            client_sock.close()
            upstream_sock.close()
            return

    # FORWARD REQUEST
    upstream_sock.sendall(headers_final + b"\r\n\r\n" + body_start)

    # BIDIRECTIONAL TUNNEL (The fix for interactive sessions)
    # We listen to both sockets.
    # If client sends data (stdin) -> send to upstream.
    # If upstream sends data (stdout/response) -> send to client.
    sockets = [client_sock, upstream_sock]

    while True:
        # Wait for data to be available on either socket
        try:
            readable, _, _ = select.select(sockets, [], [])
        except select.error:
            break

        if client_sock in readable:
            try:
                data = client_sock.recv(4096)
                if not data:
                    break  # Client closed
                upstream_sock.sendall(data)
            except OSError:
                break

        if upstream_sock in readable:
            try:
                data = upstream_sock.recv(4096)
                if not data:
                    break  # Server closed
                client_sock.sendall(data)
            except OSError:
                break

    client_sock.close()
    upstream_sock.close()


def main():
    if os.path.exists(PROXY_SOCKET_PATH):
        os.remove(PROXY_SOCKET_PATH)

    server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    server.bind(PROXY_SOCKET_PATH)
    server.listen(10)

    print(f"Podman Guard active. Root: {ALLOWED_DIR}")

    while True:
        client, _ = server.accept()
        t = threading.Thread(target=handle_client, args=(client,))
        t.daemon = True
        t.start()


if __name__ == "__main__":
    main()
