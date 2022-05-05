-- Commands

local create = vim.api.nvim_create_user_command
local job = require('plenary.job')

-- overmind connect in a tmux popup
create('Oc', function(args)
  os.execute('tmux popup -E -d $(pwd) -h 80% -w 80% overmind connect ' .. args.args)
end, {
  nargs = 1,
  desc = 'Connect to overmind in a tmux popup window',
})

-- save
create('Save', function(args)
  vim.api.nvim_exec('write', true)

  local cwd = vim.fn.getcwd()
  local notesdir = os.getenv('HOME') .. '/notes'
  local is_notes = string.find(cwd, notesdir)

  if is_notes then
    local filepath = vim.fn.expand('%:.')
    local filename = vim.fn.expand('%:t')
    local timestamp = vim.fn.strftime('%Y-%m-%dT%H:%M:%S%z')

    -- update frontmatter timestamp
    job:new({
      command = 'sed',
      args = {'-i', 's/modified:.*/modified: ' .. timestamp .. '/g', filepath},
      cwd = cwd,
    }):sync()
    vim.api.nvim_exec('e', true)

    local git_add = 'git add ' .. filepath
    local msg = 'Updated Note ' .. filename
    local git_commit = 'git commit -m "' .. msg .. '"'
    local git_push = 'git push origin master'
    local cmd = git_add .. ' && ' .. git_commit .. ' && ' .. git_push

    -- commit and push
    job:new({
      command = 'sh',
      args = {'-c', cmd},
      cwd = cwd,
      on_exit = function(j, return_val)
        if return_val == 0 then
          print('[Notes] pushed!')
        else
          print('[Notes] [WARN] push failed!')
        end
      end,
    }):start()
  end
end, {
  nargs = 0,
  desc = 'Save current buffer. commit and push notes',
})
