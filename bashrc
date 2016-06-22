#!/usr/bin/env bash

source ~/.bash/config

# aliases
source ~/.bash/aliases

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
