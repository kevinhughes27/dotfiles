-- Commands

local create = vim.api.nvim_create_user_command
local Job = require('plenary.job')

-- overmind connect in a tmux popup
create("Oc", function(args)
  os.execute("tmux popup -E -d $(pwd) -h 80% -w 80% overmind connect " .. args.args)
end, {
  nargs = 1,
  desc = "Connect to overmind in a tmux popup window",
})

-- save
create("Save", function(args)
  vim.api.nvim_exec("write", true)

  local cwd = vim.fn.getcwd()
  local notesdir = os.getenv("HOME") .. "/notes"

  if string.find(cwd, notesdir) then
    local git_add = "git add " .. vim.fn.expand('%:.')
    local msg = "Updated Note " .. vim.fn.expand('%:t')
    local git_commit = "git commit -m '" .. msg .. "'"
    local git_push = "git push origin master"

    local  cmd = git_add .. " && " .. git_commit .. " && " .. git_push

    Job:new({
      command = 'sh',
      args = {'-c', cmd},
      cwd = cwd,
      on_exit = function(j, return_val)
        if return_val == 0 then
          print("Notes pushed!")
        else
          print("[WARN] Notes push failed!")
        end
      end,
    }):start()
  end

end, {
  nargs = 0,
  desc = "Save current buffer. commit and push notes"
})
