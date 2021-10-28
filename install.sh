#!/bin/zsh

# Install script for my dotfiles
# ------------------------------
# Has 2 components - backing up existing files
# and then simlinking the files in the dotfiles
# folder to the home directory. The script is
# idempotent and can be run many times safely.
#
# On the first run it will backup any existing
# files - this makes sure you don't remove something
# system specific. On subsequent runs it will
# detect that the file is a symlink to ~/dotfiles and
# ignore it.

echo ""
echo "Backup the original files"
echo "-------------------------"

function backup() {
  # backs up the file/folder the first time only
  file="$1"

  # simlink already exists
  if [[ -L $file ]] && [[ "`readlink $file`" == *"dotfiles"* ]]; then
    echo "Simlink already exists for '$file'"
  # file exists
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

DIR=`realpath $0 | sed 's/\/install.sh//'`

function link() {
  from="$DIR/$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

link zshrc ~/.zshrc
link tmux.conf ~/.tmux.conf
link gitconfig ~/.gitconfig
link gitignore ~/.gitignore

link alacritty ~/.config/alacritty
link bottom ~/.config/bottom
link starship.toml ~/.config/starship.toml
link nvim ~/.config/nvim

echo ""
echo "All done."
