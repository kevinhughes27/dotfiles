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

backup ~/.bash_profile

backup ~/.bashrc
backup ~/.bash

backup ~/.zshrc
backup ~/.zsh

backup ~/.tmux.conf
backup ~/.gitconfig
backup ~/.gitignore
backup ~/.vimrc

sublime_path="$HOME/.config/sublime-text-2/Packages/User/Preferences.sublime-settings"
if [[ `uname` == 'Darwin' ]]; then
  sublime_path="$HOME/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings"
fi

backup $sublime_path

# oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing oh-my-zsh"
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
else
  echo "updating oh-my-zsh"
  cd ~/.oh-my-zsh
  git pull
  cd ~
fi

echo "Symlinking files:"
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
link ~/dotfiles/sublime/Packages/User/Preferences.sublime-settings "$sublime_path"

echo "All done."
