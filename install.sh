#!/usr/bin/env bash

# Install script for my dotfiles
# ------------------------------
# Has 2 components - backing up existing files
# and then simlinking the files in the dotfiles
# folder to the home directory. The script is
# idempotent and can be run many times safely.
#
# On the first run it will backup any existing
# files - this makes sure you don't remove something
# system specific etc. On subsequent runs it will
# detect that the file is a symlink to dotfiles and
# ignore it.

# changes the internal field separator to a newline only
IFS='
'

echo ""
echo "Backup the original files"
echo "-------------------------"
echo ""

backup() {
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
  # folder exists
  elif [[ -d $file ]]; then
    if [[ ! -d "$file.old" ]]; then
      echo "Backup '$file' to '$file.old'"
      mv $file "$file.old"
    fi
  fi
}

backup ~/.bash_profile
backup ~/.bashrc
backup ~/.bash

backup ~/.zshrc
backup ~/.zsh
backup ~/.tmux.conf

backup ~/.gitconfig
backup ~/.gitignore

backup ~/.vimrc
backup ~/.atom

# oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing oh-my-zsh"
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

echo ""
echo "Symlinking files:"
echo "-----------------"
echo ""

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

link ~/dotfiles/bash_profile ~/.bash_profile
link ~/dotfiles/bashrc ~/.bashrc
link ~/dotfiles/bash ~/.bash

link ~/dotfiles/zshrc ~/.zshrc
link ~/dotfiles/zsh ~/.zsh
link ~/dotfiles/tmux.conf ~/.tmux.conf

link ~/dotfiles/gitconfig ~/.gitconfig
link ~/dotfiles/gitignore ~/.gitignore

link ~/dotfiles/vimrc ~/.vimrc
link ~/dotfiles/atom ~/.atom

echo ""
echo "All done."
