let g:rspec_command = "!bundle exec rspec {spec}"
map <C-t> :call RunCurrentSpecFile()<CR>
map <C-s> :call RunNearestSpec()<CR>
map <C-l> :call RunLastSpec()<CR>
