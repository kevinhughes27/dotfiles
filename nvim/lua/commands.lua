-- Commands

-- overmind connect in a tmux popup
vim.api.nvim_exec([[
command! -nargs=1 Oc :silent !tmux popup -E -d $(pwd) -h 80\% -w 80\% overmind connect <f-args>
]], true)

-- remember last cursor position (ignore NvimTree)
vim.api.nvim_exec([[
function RestoreCursor()
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

-- save
vim.api.nvim_exec([[
function Save()
  write

  let cwd = getcwd()
  let notesdir = $HOME."/notes"

  if cwd =~ notesdir
    let git_add = "git add ".expand('%:.')
    let msg = "Updated Note ".expand('%:t')
    let git_commit = "git commit -m '".msg."'"
    let git_push = "git push origin master"

    let cmd = git_add." && ".git_commit." && ".git_push

    call jobstart(cmd)
  endif
endfunction
]], true)

-- set word wrap for markdown files
vim.api.nvim_exec([[
autocmd bufreadpre *.md setlocal wrap linebreak nolist
]], true)
