#!/bin/bash

# eg. alias e=echo

# Bundler Commands
alias be='bundle exec'
alias bi='bundle install'
alias bl='bundle list'
alias bu='bundle update'
alias bp='bundle package'

alias ber='bundle exec rake'
alias bez='bundle exec zeus'

# Git Commands
alias gitfix='git rebase -i HEAD~2'
alias gs='git status'
function gp {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      local branch=${BASH_REMATCH[1]}
      if [[ "$branch" =~ "master" ]]; then
        read -p "push master, Are you sure? " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          echo
          echo "$(git push origin) $branch"
        else
          echo
          echo 'git push aborted.'
        fi  
      else
        echo "$(git push origin) $branch"
      fi
    else
      echo 'not on a branch'
    fi
  else
    echo 'Not a git repo'
  fi
}
