#!/bin/zsh

function _tmux_window_unamed () {
  local current_window_name=$(tmux display-message -p '#W')
  [[ "$current_window_name" = "zsh" ]]
}

chpwd() {
  if [[ -d '.git' ]] && _tmux_window_unamed; then
    tmux rename-window $(basename $(pwd))
  fi
}
