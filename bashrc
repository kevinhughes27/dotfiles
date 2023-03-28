# prompt
GREEN="\[\e[01;38;2;152;195;121m\]"
RED="\[\e[01;38;2;224;108;117m\]"
BLUE="\[\e[00;38;2;97;175;239m\]"
RESET="\[\e[00m\]"
PS1="${GREEN}\u${RESET}@${RED}\h${RESET} \n${BLUE} ❯ ${RESET}"

# to change hostname:
# sudo hostnamectl set-hostname <name>

# history
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignorespace:ignoredups

# case insensitive completion
[[ $- == *i* ]] && bind 'set completion-ignore-case on'

# fzf if present
if [[ -d "$HOME/.fzf" ]]; then
  # setup fzf
  if [[ ! "$PATH" == "*$HOME/.fzf/bin*" ]]; then
    PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
  fi

  # auto-completion
  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

  # key bindings
  source "$HOME/.fzf/shell/key-bindings.bash"

  # colors (onedark)
  green="#98c379"
  blue="#61afef"
  yellow="#e5c07b"
  magenta="#c678dd"

  export FZF_DEFAULT_OPTS="--reverse --height=50%
    --color=dark
    --color=fg:-1,bg:-1,hl:$magenta
    --color=fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
    --color=info:$green,prompt:$blue,pointer:$magenta
    --color=marker:$yellow,spinner:$blue,header:$blue,gutter:-1"
fi

# aliases
alias gs='git status'
alias gr='git r'
alias gp='git p'
