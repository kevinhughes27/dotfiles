#!/usr/bin/env bash

export EDITOR="vim"

export HISTCONTROL="ignoredups"
export HISTCONTROL=erasedups

bind 'set completion-ignore-case on'

export CLICOLOR=1
source ~/.bash/colors.bash

# prompt
export  PS1="\[$ORANGE\]\u@\h:\[$YELLOW\]\$(__git_ps1)\[$RED\][\w]\[$NORMAL\] "

# aliases
source ~/.bash/aliases.bash

# completetions
source ~/.bash/git-completion.bash
source ~/.bash/pip-completion.bash
source ~/.bash/gem-completion.bash
source ~/.bash/rake-completion.bash

# scripts
source ~/.bash/git-prompt.sh
source ~/.bash/colored_man.bash

# Shopify
#source /opt/boxen/env.sh
