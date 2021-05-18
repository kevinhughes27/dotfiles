# prompt
eval "$(starship init zsh)"

# completions
autoload -U compaudit compinit
autoload -U +X bashcompinit && bashcompinit
compinit -i -C -d "${HOME}/.zcompdump"

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''

# source fzf
fzf_base=$(brew --prefix fzf)
fzf_shell="${fzf_base}/shell"
source "${fzf_shell}/completion.zsh" 2> /dev/null
source "${fzf_shell}/key-bindings.zsh"

# sometimes bat is installed as batcat.
if command -v batcat > /dev/null; then
  BATNAME="batcat"
elif command -v bat > /dev/null; then
  BATNAME="bat"
fi

# configuration
export EDITOR='nvim'
export BAT_THEME='OneHalfDark'
export OVERMIND_TMUX_CONFIG="$HOME/dotfiles/overmind.tmux.conf"

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--reverse --height=50%'
export FZF_CTRL_T_OPTS="--preview '$BATNAME --color=always --line-range :50 {}' --preview-window right:70%"

# fzf one dark theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'

# autoload
for file in ~/dotfiles/zsh/*; do
  source "$file"
done

# aliases
alias vi='nvim'
alias gs='git status'
alias ga='git add'
alias gr='git r'
alias gf='git fr'
alias bi='bundle install'
alias bx='bundle exec'
alias dc='docker-compose'

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

# start tmux once
tmuxify
