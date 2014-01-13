#!/usr/bin/env bash

echo "Backup the original files"
backup() {
  # backs up the file/folder the first time only
  file="$1"
  if [[ -f $file ]]; then
    if [[ ! -f "$file.old" ]]; then
      mv $file "$file.old"
    fi
  elif [[ -d $file ]]; then
    if [[ ! -d "$file.old" ]]; then
      mv $file "$file.old"
    fi
  fi
}

backup ~/.bashrc
backup ~/.bash_profile
backup ~/.bash
backup ~/.tmux.conf
backup ~/.gitconfig
backup ~/.gitignore
backup ~/.vimrc

sublime_path="$HOME/.config/sublime-text-2/Packages/User/Preferences.sublime-settings"
if [[ `uname` == 'Darwin' ]]; then
  sublime_path="$HOME/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings"
fi

backup $sublime_path

echo "Symlinking files:"
link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

link ~/dotfiles/bashrc ~/.bashrc
link ~/dotfiles/bash_profile ~/.bash_profile
link ~/dotfiles/bash ~/.bash
link ~/dotfiles/tmux.conf ~/.tmux.conf
link ~/dotfiles/gitconfig ~/.gitconfig
link ~/dotfiles/gitignore ~/.gitignore
link ~/dotfiles/vimrc ~/.vimrc
link ~/dotfiles/sublime/Packages/User/Preferences.sublime-settings "$sublime_path"

echo "All done."

echo "Reloading"
exec bash
