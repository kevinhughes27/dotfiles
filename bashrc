#!/usr/bin/env bash

export EDITOR="vim"

# add line number to LESS prompt
export LESS='-RS#3NM~g'

# history
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTCONTROL="ignoredups"
export HISTCONTROL=erasedups

# help with case in completion
bind 'set completion-ignore-case on'

# colors
export CLICOLOR=1
source ~/.bash/colors.bash

# prompt
export  PS1="\[$PURPLE\]\u@\h:\[$YELLOW\]\$(__git_ps1)\[$RED\][\w]\[$NORMAL\] "

# aliases
source ~/.bash/aliases.bash

# completetions
source ~/.bash/git-completion.bash
source ~/.bash/pip-completion.bash
source ~/.bash/gem-completion.bash

# scripts
source ~/.bash/git-prompt.sh
source ~/.bash/colored_man.bash
