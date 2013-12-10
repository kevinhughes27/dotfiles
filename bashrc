#!/usr/bin/env bash

# prompt
#PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$
#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\]\u@\H\\$\[$(tput sgr0)\] " 
export PS1="\[\e[32m\]\u@\h:\[\033[0;33m\]\$(__git_ps1) \[\e[31m\][\w]$\[\e[0m\] "
export CLICOLOR=1

source ~/.bash/config.bash

# aliases
source ~/.bash/aliases.bash

# completetions
source ~/.bash/git-completion.bash
source ~/.bash/gem-completion.bash
source ~/.bash/pip-completion.bash
source ~/.bash/rake-completion.bash
source ~/.bash/brew-completion.bash

# scripts
source ~/.bash/git-prompt.sh
source ~/.bash/colored_man.bash
source ~/.bash/history.bash

# Shopify
#source /opt/boxen/env.sh
