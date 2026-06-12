-- Commands
--
local create = vim.api.nvim_create_user_command

-- ripgrep shortened command
-- no arg resumes previous search
create('Rg', function(opts)
  local fzf_lua = require('fzf-lua')
  local grep_opts = {}

  grep_opts.search = opts.fargs[1]

  if grep_opts.search == nil then
    fzf_lua.live_grep({resume = true})
  else
    fzf_lua.live_grep(grep_opts)
  end
end, {
  nargs = '?',
  desc = 'Start FzfLua live_grep'
})

-- copy current file path
create('CopyPath', function()
  vim.api.nvim_exec2('let @+=@%', {})
end, {
  nargs = 0,
  desc = 'Copy the path of the current file to clipboard',
})

-- ruff
create('Ruff', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'source.fixAll.ruff' }
    },
    apply = true,
  }
  vim.lsp.buf.format { async = true }
end, {
  desc = "Reformat python with ruff"
})

-- LSP restart
create('LspRestart', function()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print("No LSP clients found")
    return
  end

  -- Stop all clients using the correct API
  for _, client in ipairs(clients) do
    vim.lsp.client.stop(client)
  end

  -- Wait a moment then restart by reloading the buffer
  vim.defer_fn(function()
    vim.cmd('edit')
  end, 100)

  print("Restarted " .. #clients .. " LSP client(s)")
end, {
  desc = "Restart all LSP clients"
})

-- notes push
create('Np', function()
  local cwd = vim.fn.getcwd()
  local notesdir = os.getenv('HOME') .. '/notes'
  local is_notes = string.find(cwd, notesdir)

  if is_notes then
    -- git add (synchronous wait)
    vim.system({ 'git', 'add', '.' }, { cwd = cwd }):wait()

    -- update view
    vim.api.nvim_exec2('Gitsigns refresh', {})

    -- commit and push
    local git_commit = 'git commit -m "Updated Notes"'
    local git_push = 'git push origin master'
    local cmd = git_commit .. ' && ' .. git_push

    -- async system call
    vim.system({ 'sh', '-c', cmd }, { cwd = cwd }, function(out)
      -- Schedule prints to the main event loop
      vim.schedule(function()
        if out.code == 0 then
          print('[Notes] pushed!')
        elseif out.stdout:find('nothing to commit') or (out.stderr and out.stderr:find('nothing to commit')) then
          print('[Notes] nothing to commit')
        else
          print('[Notes] [WARN] push failed!')
        end
      end)
    end)
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
