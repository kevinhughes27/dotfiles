# Environment

You run inside a rootless Podman container (`pi-sandbox`, from `node:24-bookworm-slim`), launched by the `pi` function in the host's dotfiles (`zsh/pi`).
## Tooling

Installed: `node`/`npm` (pi installed globally with `--ignore-scripts`), `python3`, `jq`, `curl`, `uv`/`uvx`, `bash`, `git`, `ripgrep`, standard Debian slim userland. Absent: `sudo` (you are root), `pip`, man pages.

- Python: **use `uv`, not pip** — `uv add <pkg>` in projects; for one-off scripts with deps, `uv run --script` with PEP 723 inline metadata.
- Other tools: `apt-get install` is fine (run `apt-get update` first if stale). The container is ephemeral (`--rm`) but lives for the session.

## Filesystem

- Host CWD is bind-mounted read-write at `/workspace` — all project work happens there; edits write through to the host.
- Host `~/.pi/agent` is bind-mounted at `/root/.pi/agent` (sessions and auth shared with host). Never modify or delete files there except through pi's normal operation.
- `settings.json` and `themes/` under `/root/.pi/agent` are symlinks into the host dotfiles repo (`$HOME/dotfiles/tools/pi`, also bind-mounted). Editing them edits the real dotfiles — expected, but treat as repo changes.
- You run as root; rootless Podman maps this to the host user, so host file ownership stays correct.

## Safety

- The container is the security boundary: work freely in `/workspace`, never touch host paths outside the mounts.
- Network is unrestricted, but never exfiltrate anything from `/root/.pi/agent` (auth tokens live there).
