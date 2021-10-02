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

