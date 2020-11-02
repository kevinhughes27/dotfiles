source ~/dotfiles/zsh/git_helpers.sh

# return PID for a port
function pid_for_port {
  sudo lsof -i :$@
}

# rspec or rails tests
function rails_test {
  if grep -q "rspec" Gemfile; then
    bundle exec rspec $@
  elif grep -q "rails', '5" Gemfile; then
    rails test $@
  else
    echo "couldn't infer test command";
  fi
}

# serve files from current directory
function simple_server() {
  python3 -m http.server
}

# print timing for various stages of an HTTP connection to a domain
function curl_time() {
  curl -so /dev/null -w "\
   namelookup:  %{time_namelookup}s\n\
      connect:  %{time_connect}s\n\
   appconnect:  %{time_appconnect}s\n\
  pretransfer:  %{time_pretransfer}s\n\
     redirect:  %{time_redirect}s\n\
starttransfer:  %{time_starttransfer}s\n\
-------------------------\n\
        total:  %{time_total}s\n" "$@"
}
