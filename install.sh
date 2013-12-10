#!/usr/bin/env bash

echo "Backup the old files"
mv ~/.bashrc ~/.bashrc.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.bash ~/.bash.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.gitignore ~/.gitignore.old 
mv ~/.vimrc ~/.vimrc.old


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

