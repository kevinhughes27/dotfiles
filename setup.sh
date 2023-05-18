#!/bin/bash

# Installs some dependencies then backs up existing files
# before simlinking the configuration into the home directory.
# The script is idempotent and can be run many times safely.
#
# On the first run it will backup any existing files.
# This makes sure you don't clobber any existing config
# by accident. On subsequent runs it will detect that
# the file is a symlink to ~/dotfiles and ignore it.
function setup() {
  echo ""
  echo "Dependencies"
  echo "------------"

  if ! which starship &> /dev/null; then
    echo "Installing starship.rs"
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes > /dev/null
  fi

  echo "Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &> /dev/null
  git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.fzf-tab &> /dev/null
  ~/.fzf/install --key-bindings --completion --no-update-rc --no-bash > /dev/null

  echo ""
  echo "Backup the original files"
  echo "-------------------------"

  function backup() {
    file="$1"
    if [[ -L $file ]] && [[ "`readlink $file`" == *"dotfiles"* ]]; then
      echo "Simlink already exists for '$file'"
    elif [[ -f $file ]]; then
      if [[ ! -f "$file.old" ]]; then
        echo "Backup '$file' to '$file.old'"
        mv $file "$file.old"
      fi
    fi
  }

  backup ~/.bashrc
  backup ~/.zshrc
  backup ~/.tmux.conf
  backup ~/.gitconfig

  echo ""
  echo "Symlinking files:"
  echo "-----------------"

  function link() {
    from="$1"
    to="$2"
    echo "Linking '$from' to '$to'"
    rm -rf "$to"
    ln -s "$from" "$to"
  }

  link ~/dotfiles/bashrc ~/.bashrc
  link ~/dotfiles/zshrc ~/.zshrc
  link ~/dotfiles/vimrc ~/.vimrc
  link ~/dotfiles/tmux.conf ~/.tmux.conf
  link ~/dotfiles/gitconfig ~/.gitconfig

  mkdir -p ~/.config
  link ~/dotfiles/starship.toml ~/.config/starship.toml
  link ~/dotfiles/terminals/wezterm ~/.config/wezterm
  link ~/dotfiles/terminals/alacritty ~/.config/alacritty
  link ~/dotfiles/terminals/kitty ~/.config/kitty
  link ~/dotfiles/nvim ~/.config/nvim

  link ~/dotfiles/tools/pdbrc ~/.pdbrc
  link ~/dotfiles/tools/bat ~/.config/bat
  link ~/dotfiles/tools/bottom ~/.config/bottom
  link ~/dotfiles/tools/ulauncher ~/.config/ulauncher
  link ~/dotfiles/tools/pylsp/pycodestyle ~/.config/pycodestyle

  echo ""
  echo "All done."
}


# Copy standalone configuration to a remote server.
# Back up the original remote bashrc first.
function setup-remote() {
  remote="$1"

  # backup original bashrc
  backup_check='grep "fzf" .bashrc &> /dev/null;'
  backup_cmd='if [ $? -eq 1 ]; then echo "Backup .bashrc to .bashrc.old"; cp .bashrc .bashrc.old; fi'
  ssh $remote "${backup_check} ${backup_cmd}"

  # copy configuration
  scp bashrc $remote:~/.bashrc
  scp vimrc $remote:~/.vimrc
  scp gitconfig $remote:~/.gitconfig

  # setup fzf
  ssh $remote 'git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf'
  ssh $remote '~/.fzf/install --key-bindings --completion --no-update-rc --no-zsh'
}


# Usage
# noargs        full local setup
# -r <remote>   copy minimal setup to a remote host
if [[ $# -eq 0 ]] ; then
  setup
else
  while getopts 'r:' OPTION; do
    case "$OPTION" in
      r)
        setup-remote "$OPTARG"
        ;;
    esac
  done
fi
