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

## Git

- No gpg here, so commits are unsigned. Commit as `pi.agent` without touching the repo's git config: `git -c user.name='pi.agent' -c user.email='pi.agent@localhost' commit -m ...`
- Message: short subject, then a body with the context (the why, and what was rejected). Batch commits are fine and encouraged when a direction naturally splits into several.
- When the work is ready for review, stop and summarize: name the commit range and how to read it (`git log <base>..HEAD`, `git show <sha>`), and give the host command to sign the range and take authorship (author dates reset to now): `git rebase -i <last-signed-commit> --exec 'git commit --amend -S --no-edit --reset-author'`.

## Commenting

- Write comments and docs for the future reader, not for the current conversation. Omit path-dependent content: references to how we got here, what was tried and rejected mid-session, what a thing used to be, or who asked for it. If the history matters it belongs in the commit message, not the code.
- This applies to READMEs and docs too — describe what the thing *is*, not the process that produced it.

## Safety

- The container is the security boundary: work freely in `/workspace`, never touch host paths outside the mounts.
- Network is unrestricted, but never exfiltrate anything from `/root/.pi/agent` (auth tokens live there).
