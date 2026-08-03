# Pi Packages

Custom [pi](https://github.com/earendil-works/pi) packages live here, one
directory per package. They are tracked in this repo and loaded by pi as
local path sources, so no symlinking is required.

See the official docs for package structure and the full feature set:
`docs/packages.md` in the pi installation, or
<https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/packages.md>

## Adding a new package

1. Create a directory here following pi's conventions:

   ```
   packages/my-package/
     extensions/   # .ts / .js extension files
     skills/       # SKILL.md folders or top-level .md files
     prompts/      # .md prompt templates
     themes/       # .json themes
   ```

   Any of these directories is optional; only include what you use.
   Alternatively, declare resources explicitly with a `pi` manifest in a
   `package.json` (see the official docs).

2. Register it in `~/.pi/agent/settings.json` (symlinked to
   `tools/pi/settings.json` in this repo) as a local path source:

   ```json
   {
     "packages": ["~/dotfiles/tools/pi/packages/my-package"]
   }
   ```

   Use the `~/dotfiles` absolute path rather than a relative one. Relative
   paths resolve against the settings file's directory, which is fragile
   because `settings.json` is a symlink into this repo.

## Notes specific to this dotfiles setup

- Nothing under `~/.pi/agent/npm/` or `~/.pi/agent/git/` should ever be
  committed. Those are generated artifacts materialized from the `packages`
  array in `settings.json` (like `~/.fzf`).
- Shared, single-purpose resources that don't need to be a full package
  (e.g. `themes/`) live directly under `tools/pi/` and are symlinked by
  `setup.sh` instead.
- Once a package outgrows this repo, move it to its own git repository and
  install it with `pi install git:github.com/<user>/<repo>`. It then syncs
  across machines through `settings.json` like any third-party package.
