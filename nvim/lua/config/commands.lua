-- Commands
--
local create = vim.api.nvim_create_user_command
local job = require('plenary.job')

-- ripgrep shortened command
create('Rg', function(opts)
  local grep_opts = {}
  grep_opts.search = opts.fargs[1]
  require('fzf-lua').live_grep(grep_opts)
end, {
  nargs = '?',
  desc = 'Start FzfLua live_grep'
})

-- notes push
create('Np', function()
  local cwd = vim.fn.getcwd()
  local notesdir = os.getenv('HOME') .. '/notes'
  local is_notes = string.find(cwd, notesdir)

  if is_notes then
    -- git add
    job:new({ command = 'git', args = {'add', '.'}, cwd = cwd, }):sync()

    -- update view
    vim.api.nvim_exec('Gitsigns refresh', true)

    -- commit and push
    local git_commit = 'git commit -m "Updated Notes"'
    local git_push = 'git push origin master'
    local cmd = git_commit .. ' && ' .. git_push

    local nothing_to_commit = function(result)
      return string.find(table.concat(result, ""), "nothing to commit")
    end

    job:new({
      command = 'sh',
      args = {'-c', cmd},
      cwd = cwd,
      on_exit = function(j, return_val)
        if return_val == 0 then
          print('[Notes] pushed!')
        elseif nothing_to_commit(j:result()) then
          print('[Notes] nothing to commit')
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

-- copy current file path
create('CopyPath', function()
  vim.api.nvim_exec('let @+=@%', true)
  require('osc52').copy_register('+')
end, {
  nargs = 0,
  desc = 'Copy the path of the current file to clipboard',
})

-- copy link to current file on github
create('GH', function()
  require('gitlinker').get_buf_range_url('n', {
    action_callback = function(url)
      vim.api.nvim_command('let @+ = \'' .. url .. '\'')
      require('osc52').copy_register('+')
    end,
  })
end, {
  nargs = 0,
  desc = 'Copy the link to the file on GitHub'
})
