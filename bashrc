# prompt
GREEN="\e[01;38;2;152;195;121m"
RED="\e[01;38;2;224;108;117m"
BLUE="\e[00;38;2;97;175;239m"
RESET="\e[00m"
PS1="${GREEN}\u${RESET}@${RED}\h${RESET} \n${BLUE} ❯ ${RESET}"

# history
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignorespace:ignoredups

# case insensitive completion
bind 'set completion-ignore-case on'

# source fzf
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# then run ~/.fzf/install to create this file.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# aliases
alias gs='git status'
alias gr='git r'
