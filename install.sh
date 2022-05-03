#!/bin/bash

# Installs some dependencies then backs up existing files
# before simlinking the configuration into the home directory.
# The script is idempotent and can be run many times safely.
#
# On the first run it will backup any existing files.
# This makes sure you don't clobber any existing config
# by accident. On subsequent runs it will detect that
# the file is a symlink to ~/dotfiles and ignore it.

if ! which starship &> /dev/null; then
  echo "Installing starship.rs"
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes > /dev/null
fi

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &> /dev/null
git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.fzf-tab &> /dev/null
~/.fzf/install --key-bindings --completion --no-update-rc --no-bash > /dev/null

echo ""
echo "Backup the original files"
echo "-------------------------"

function backup() {
  file="$1"
  if [[ -L $file ]] && [[ "`readlink $file`" == *"dotfiles"* ]]; then
    echo "Simlink already exists for '$file'"
  elif [[ -f $file ]]; then
    if [[ ! -f "$file.old" ]]; then
      echo "Backup '$file' to '$file.old'"
      mv $file "$file.old"
    fi
  fi
}

backup ~/.zshrc
backup ~/.tmux.conf
backup ~/.gitconfig
backup ~/.gitignore

echo ""
echo "Symlinking files:"
echo "-----------------"

function link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -rf "$to"
  ln -s "$from" "$to"
}

link ~/dotfiles/zshrc ~/.zshrc
link ~/dotfiles/tmux.conf ~/.tmux.conf
link ~/dotfiles/gitconfig ~/.gitconfig
link ~/dotfiles/gitignore ~/.gitignore
link ~/dotfiles/pdbrc ~/.pdbrc

link ~/dotfiles/starship.toml ~/.config/starship.toml
link ~/dotfiles/alacritty ~/.config/alacritty
link ~/dotfiles/kitty ~/.config/kitty
link ~/dotfiles/bottom ~/.config/bottom
link ~/dotfiles/nvim ~/.config/nvim
link ~/dotfiles/ulauncher ~/.config/ulauncher

echo ""
echo "All done."
