-- Commands

local create = vim.api.nvim_create_user_command

-- overmind connect in a tmux popup
create("Oc", function(args)
  os.execute("tmux popup -E -d $(pwd) -h 80% -w 80% overmind connect " .. args.args)
end, {
  nargs = 1,
  desc = "Connect to overmind in a tmux popup window",
})

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
