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

-- copy current file path
create('CopyPath', function()
  vim.api.nvim_exec('let @+=@%', true)
  require('osc52').copy_register('+')
end, {
  nargs = 0,
  desc = 'Copy the path of the current file to clipboard',
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

-- NotesRebase
--
-- in ~/notes first:
-- git rebase --root --interactive
--
-- then run this command in vim to automatically edit the rebase file
--
-- may stop and have to run
-- git commit --amend --allow-empty
-- git rebase --continue
--
-- need to delete GitJournal repo after and set it up again
-- have the app generate a key that I add as a deploy key.
--
create('NotesRebase', function()
  local buf = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(buf)

  local function get_git_commit_dates()
    local handle = io.popen("git log --date=short --pretty=format:'%h %cd'")
    local result = handle:read("*a")
    handle:close()

    local commit_date_lookup = {}

    for line in result:gmatch("[^\r\n]+") do
      local sha, date = line:match("(%S+)%s+(%S+)")
      if sha and date then
        commit_date_lookup[sha] = date
      end
    end

    return commit_date_lookup
  end

  local commit_dates = get_git_commit_dates()

  for i = 2, line_count do
    local line = vim.api.nvim_buf_get_lines(buf, i - 1, i, false)[1]

    -- first blank line is the end of the commits. we are done
    if line == "" then
      return
    end

    local prev_line = vim.api.nvim_buf_get_lines(buf, i - 2, i - 1, false)[1]

    local sha = string.match(line, "%a*%s(%w*)%s")
    local prev_sha = string.match(prev_line, "%a*%s(%w*)%s")

    local message = string.match(line, "%a* " .. sha .. " (.*)")
    local prev_message = string.match(prev_line, "%a* " .. prev_sha .. " (.*)")

    local date = commit_dates[sha]
    local prev_date = commit_dates[prev_sha]

    if message == prev_message then -- the commmits match
      if date == prev_date then -- the date also matches
        local edited_line = string.gsub(line, "pick", "fixup")
        vim.api.nvim_buf_set_lines(buf, i - 1, i, false, {edited_line})
      end
    end
  end
end, {
  nargs = 0,
  desc = 'Helper for rebasing my notes to rollup commits',
})
