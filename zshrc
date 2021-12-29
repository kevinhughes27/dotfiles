# prompt
eval "$(starship init zsh)"

# completions
autoload -U compaudit compinit
compinit -i -C -d "${HOME}/.zcompdump"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''

# fzf-tab
# git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.fzf-tab
[[ -d ~/.fzf-tab ]] && source ~/.fzf-tab/fzf-tab.plugin.zsh

# configuration
export EDITOR='nvim'
export BAT_THEME='OneHalfDark'
export OVERMIND_TMUX_CONFIG="$HOME/dotfiles/tmux.overmind.conf"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*" --ignore-file ~/dotfiles/fzf-ignore'
export FZF_DEFAULT_OPTS='--reverse --height=50%'

# fzf one dark theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd
--color=fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046
--color=marker:#e5c07b,spinner:#61afef,header:#61afef,gutter:-1'

# source fzf
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# then run ~/.fzf/install to create this file.
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

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
[[ -f ~/.localrc ]] && source ~/.localrc

# start tmux once
tmuxify
