#!/bin/bash

# eg. alias e=echo

# Bundler Commands
alias bi='bundle install'
alias bx='bundle exec'

# Use Zeus if available otherwise Ruby
function rt {
  if [ -e .zeus.sock ]; then
    bundle exec zeus test $1
  else
    bundle exec ruby -Itest $1
  fi
}

# Git Commands
alias gs='git status'
alias checkout='git checkout'
alias branch='git branch'
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
      # branch is not master
      else
        echo "$(git push origin) $branch $@"
      fi
    else
      echo 'not on a branch'
    fi
  else
    echo 'Not a git repo'
  fi
}
