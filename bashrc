#!/usr/bin/env bash

source ~/.bash/config

# aliases
source ~/.bash/aliases

# scripts
source ~/.bash/colored_man

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
