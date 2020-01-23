# editor
export EDITOR="vim"

# add line number to LESS prompt
export LESS='-RS#3NM~g'

# don't put duplicate lines or lines starting with space in the his
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# history size
export HISTSIZE=1000
export HISTFILESIZE=2000

# help with case in completion
bind 'set completion-ignore-case on'

# aliases
source ~/dotfiles/shell/functions.sh
source ~/dotfiles/shell/aliases.sh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
