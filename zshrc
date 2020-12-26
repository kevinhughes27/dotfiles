# Init
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo ""
  echo "Installing oh-my-zsh"
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="candy" # candy, refined, fox

# Plugin configuration
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false
ZSH_TMUX_CONFIG=~/dotfiles/tmux.conf

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  colored-man-pages
  docker
  docker-compose
  heroku
  jsontools
  direnv
  tmux
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
