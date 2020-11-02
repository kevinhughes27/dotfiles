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

# interactive rebase from the branch point
function git_rebase_i {
  local currbranch=`git rev-parse --abbrev-ref HEAD`
  local branchpoint=`git merge-base master $currbranch`
  git rebase -i $branchpoint $currbranch
}

# rebase the current branch against fresh master
function git_rebase {
  local curbranch=`git rev-parse --abbrev-ref HEAD`
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

# cleanup git branches that don't exist on origin
# if the branch isn't on origin it usually means I've merged and deleted it
# aka I don't need it anymore. However this check will also find branches that
# have never been pushed so it is important to read the output before proceeding.
function git_clean () {
  git checkout master > /dev/null 2>&1;
  git fetch --all > /dev/null

  local remote_branches=`git remote prune origin --dry-run | sed "s/^.*origin\///g"`
  local local_branches=`git branch | sed "s/ *//g"`
  local removable_branches=`comm -12 <(echo "$local_branches") <(echo "$remote_branches")`

  echo "The following branches have no remote and will be removed:"
  echo
  echo $removable_branches | tr ' ' '\n'
  echo
  echo "Remove branches? (y/n)"
  read REPLY
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo $removable_branches | while read -r branch; do
      git branch -D $branch
    done
    echo "done"
  fi
}