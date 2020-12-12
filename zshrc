# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# candy, refined, fox
ZSH_THEME="candy"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  colored-man-pages
  docker
  docker-compose
  heroku
  jsontools
)

source $ZSH/oh-my-zsh.sh

# user configuration
export EDITOR='vim'
export LESS='-RS#3NM~g' # add line number to LESS prompt
export OVERMIND_TMUX_CONFIG="$HOME/dotfiles/overmind.tmux.conf"
export BAT_THEME="OneHalfDark"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# autoload
for file in ~/dotfiles/zsh/*; do
  source "$file"
done

# aliases
alias gs='git status'
alias ga='git add'
alias bi='bundle install'
alias bx='bundle exec'

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

tmuxify
