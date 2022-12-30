# prompt
GREEN="\e[01;38;2;152;195;121m"
RED="\e[01;38;2;224;108;117m"
BLUE="\e[00;38;2;97;175;239m"
RESET="\e[00m"
PS1="${GREEN}\u${RESET}@${RED}\h${RESET} \n${BLUE} ❯ ${RESET}"

# history
HISTCONTROL=ignoreboth # no duplicates or lines starting with space
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend

# case insensitive completion
bind 'set completion-ignore-case on'

# aliases
alias gs='git status'
alias gr='git r'
alias gf='git fr'
