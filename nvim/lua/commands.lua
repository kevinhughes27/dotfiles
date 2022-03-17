-- Commands

-- overmind connect in a tmux popup
vim.api.nvim_exec([[
command! -nargs=1 Oc :silent !tmux popup -E -d $(pwd) -h 80\% -w 80\% overmind connect <f-args>
]], true)

-- remember last cursor position (ignore NvimTree)
vim.api.nvim_exec([[
function! RestoreCursor()
  if &ft =~ 'NvimTree'
    return
  endif

  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call RestoreCursor()
augroup END
]], true)

-- set word wrap for markdown files
vim.api.nvim_exec([[
autocmd bufreadpre *.md setlocal wrap linebreak nolist
]], true)
