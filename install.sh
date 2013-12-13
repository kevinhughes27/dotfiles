#!/usr/bin/env bash

echo "Backup the old files"
# if present then backup to '*.old'
if [ -f ~/.bashrc ]; then mv ~/.bashrc ~/.bashrc.old; fi
if [ -f ~/.bash_profile ]; then mv ~/.bash_profile ~/.bash_profile.old; fi
if [ -f ~/.tmux.conf ]; then mv ~/.tmux.conf ~/.tmux.conf.old; fi
if [ -f ~/.gitconfig ]; then mv ~/.gitconfig ~/.gitconfig.old; fi
if [ -f ~/.gitignore ]; then mv ~/.gitignore ~/.gitignore.old; fi
if [ -f ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.old; fi

echo "Backup the old folders"
# if '*.old' present then remove it, then backup to '*.old'
if [ -d ~/.bash.old ]; then rm -r ~/.bash.old; fi
if [ -d ~/.bash ]; then mv ~/.bash ~/.bash.old; fi

echo "Symlinking files"
ln -s ~/dotfiles/bashrc ~/.bashrc
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/bash ~/.bash
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore ~/.gitignore
ln -s ~/dotfiles/vimrc ~/.vimrc

echo "All done."

echo "Reloading"
exec bash
