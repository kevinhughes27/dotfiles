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

# editor
export EDITOR='nvim'

# bat theme
export BAT_THEME='OneHalfDark'

# colors (onedark)
green="#98c379"
blue="#61afef"
yellow="#e5c07b"
magenta="#c678dd"

# fzf configuration
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--reverse --height=50%
--color=dark
--color=fg:-1,bg:-1,hl:$magenta
--color=fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:$green,prompt:$blue,pointer:$magenta
--color=marker:$yellow,spinner:$blue,header:$blue,gutter:-1"

# source fzf
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# then run ~/.fzf/install to create this file.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf-tab
# git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.fzf-tab
[ -d ~/.fzf-tab ] && source ~/.fzf-tab/fzf-tab.plugin.zsh

# autoload
for file in ~/dotfiles/zsh/*; do
  source "$file"
done

# aliases
alias vi='nvim'
alias gs='git status'
alias gr='git r'
alias bi='bundle install'
alias bx='bundle exec'
alias dc='docker-compose'
alias rw='tmux rename-window'

# remove extra new lines from paste
bracketed-paste() {
  zle .$WIDGET && LBUFFER=${LBUFFER%$'\n'}
}
zle -N bracketed-paste

# auto rename windows
[ -v TMUX ] && source ~/dotfiles/tmux/auto-rename.sh

# use .localrc for settings specific to one system
[ -f ~/.localrc ] && source ~/.localrc

# start tmux once
tmuxify
