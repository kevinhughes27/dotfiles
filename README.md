dotfiles
========

My personal toolkit. Locally I use `neovim` for my editor, `zsh` for my shell with `starship.rs` for the prompt and `tmux` for window managment. For my terminal I am currently using `wezterm` but I keep configuration for `alacritty` and `kitty` handy. `bashrc`, `vimrc` and `gitconfig` are standalone and can be copied to remote hosts if I need.

![screenshot](https://user-images.githubusercontent.com/1965489/210177151-84c27c26-2c4f-4e78-a644-7f4bb86e7d45.png)

dependencies
------------

The `setup` script will do most of the work but there are a few dependencies that need to be installed manually with the system package manager or built from source. `cargo` can be used for the rust dependencies:

  * `zsh`
  * `tmux` (greater than 3.2a, prefer head)
  * `neovim` (greater than 0.8, prefer nightly)
  * `bat` / `batcat`
  * `rg` / `ripgrep`

Fonts also need to be configured on the base host (the system that runs the terminal). I haven't automated this because terminal installation is also manual:

```sh
if [ uname = "Darwin" ]; then
  FONT_DIR="~/Library/Fonts"
else
  FONT_DIR="~/.local/share/fonts"
fi

mkdir -p $FONT_DIR
cd $FONT_DIR

FONT_URL="https://github.com/kevinhughes27/font-patcher/raw/master/fonts/Hack%20Regular%20Nerd%20Font%20Complete.ttf"
curl -fLo "Hack Regular Nerd Font Complete.ttf" $FONT_URL
```

For Alacritty on Linux a fallback font config is needed for color emoji:
https://github.com/alacritty/alacritty/issues/153#issuecomment-630636358

`~/.config/fontconfig/fonts.conf`:

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>Hack Nerd Font</family> <!-- Font name you reference in alacritty.yml -->
    <prefer>
      <family>Hack Nerd Font</family> <!-- Your preferred monospace font -->
      <family>Noto Color Emoji</family> <!-- Your preferred emoji font -->
     </prefer>
  </alias>
</fontconfig>
```

OSX does not have an equivalent and until Alacritty adds its own configuration for fallback fonts color emojis do not work with a patched nerd font.
https://github.com/alacritty/alacritty/issues/957


setup
-----

```
git clone git@github.com:kevinhughes27/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`neovim` will bootstrap itself on first open.

From a configured system `./setup.sh -r <remote>` can be used to copy my standalone `bashrc`, `vimrc` and `gitconfig` to a remote host. `fzf` will also be copied.


.localrc
--------

My `zshrc` will source a `~/.localrc` file if it exists for any system or work specific settings. This lets me maintain one set of dotfiles while still having flexability. It is pretty common for programs to automatically add config to your dotfiles and when that happens I can see the changes in git and move them to localrc.
