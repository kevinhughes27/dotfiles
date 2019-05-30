#!/bin/bash

# return PID for a port
function pid_for_port {
  sudo lsof -i :$@
}

# push the current branch, confirm master push.
# allow force push unless master
function git_push {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    args="$@"

    # filter -d command since I never want this
    if [[ "$args" =~ "-d" ]]; then
      args=""
    fi

    if [[ "$branch" != "HEAD" ]]; then
      if [[ "$branch" =~ "master" ]]; then
        echo "push master, Are you sure? (y/n)"
        read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          if [[ -n $args  ]]; then
            echo 'no force push master'
          else
            git push origin $branch
          fi
        else
          echo 'git push aborted.'
        fi
      # branch is not master, allow force option if passed
      else
        git push origin $branch $args
      fi
    else
      echo 'not on a branch'
    fi
  else
    echo 'Not a git repo'
  fi
}

# rebase the current branch against fresh master
function git_rebase {
  curbranch=`git rev-parse --abbrev-ref HEAD`
  git checkout master
  git pull origin master
  git checkout $curbranch
  git rebase master
}

# switch to master and pull
function git_fresh {
  git checkout master
  git pull origin master
}