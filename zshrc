# prompt
eval "$(starship init zsh)"

# completions
autoload -U compaudit compinit
compinit -i -C -d "${HOME}/.zcompdump"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS='yyyy-mm-dd'
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# fix home, end and delete
bindkey "^[[1~" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line

# disable ctrl s from triggering stop
stty stop undef

# remove extra new lines from paste
bracketed-paste() { zle .$WIDGET && LBUFFER=${LBUFFER%$'\n'} }
zle -N bracketed-paste

# editor
export EDITOR='nvim'

# aliases
alias vi='nvim'
alias gs='git status'
alias gr='git r'
alias gp='git p'
alias gpff='git p -f --no-verify'
alias bi='bundle install'
alias bx='bundle exec'
alias rw='tmux rename-window'
alias tf='terraform'
alias dev='./dev'

# autoload
for file in ~/dotfiles/zsh/*; do
  source "$file"
done

# auto rename windows
[ -v TMUX ] && source ~/dotfiles/tmux/auto-rename.sh

# use .localrc for settings specific to one system
[ -f ~/.localrc ] && source ~/.localrc

# start tmux once
tmuxify
