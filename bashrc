#!/usr/bin/env bash

source ~/dotfiles/bash/config

# aliases
source ~/dotfiles/shell/macros
source ~/dotfiles/shell/aliases

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
