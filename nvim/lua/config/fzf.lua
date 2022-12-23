local g = vim.g
local fn = vim.fn

if fn.exists('$TMUX') == 1 then
  g.fzf_tmux = 1
  g.fzf_layout = {
    tmux = '-p 90%,90%'
  }
else
  g.fzf_tmux = 0
  g.fzf_layout = {
    window = {
      width = 0.9,
      height = 0.9,
    }
  }
end

vim.api.nvim_create_user_command("FzfTmuxToggle", function()
  if g.fzf_tmux == 1 then
    g.fzf_tmux = 0
    g.fzf_layout = {
      window = {
        width = 0.9,
        height = 0.9,
      }
    }
  else
    g.fzf_tmux = 1
    g.fzf_layout = {
      tmux = '-p 90%,90%'
    }
  end
end, {
  nargs = 0,
  desc = "Toggle Fzf tmux to use a vim window. Needed for pairing to display fzf"
})

g.fzf_preview_window = 'right:60%:sharp'

g.fzf_colors = {
  fg =      {'fg', 'Normal'},
  bg =      {'bg', 'Normal'},
  hl =      {'fg', 'Label'},
  info =    {'fg', 'Comment'},
  border =  {'fg', 'Ignore'},
  prompt =  {'fg', 'Function'},
  pointer = {'fg', 'Statement'},
  marker =  {'fg', 'Conditional'},
  spinner = {'fg', 'Label'},
  header =  {'fg', 'Comment'}
}

g.fzf_colors['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'}
g.fzf_colors['bg+'] = {'bg', 'CursorLine', 'CursorColumn'}
g.fzf_colors['hl+'] = {'fg', 'Label'}

-- overwrite Rg to search in hidden files but not .git
vim.api.nvim_create_user_command("Rg", function(args)
  local command = 'rg \z
      --hidden \z
      --glob "!.git/*" \z
      --ignore-file ~/dotfiles/fzf-ignore \z
      --column \z
      --line-number \z
      --no-heading \z
      --color=always \z
      --smart-case \z
      -- ' .. args.args

  vim.api.nvim_exec("call fzf#vim#grep('" .. command .. "', 1, fzf#vim#with_preview())", true)

end, {
  nargs = "*",
  bang = true,
  desc = "RipgrepFzf"
})


-- live ripgrep fzf acts as selector only
vim.api.nvim_create_user_command("RG", function(args)
  local command_fmt = 'rg \z
    --hidden \z
    --glob "!.git/*" \z
    --column \z
    --line-number \z
    --no-heading \z
    --color=always \z
    --smart-case \z
    -- %s || true'

  local initial_command = string.format(command_fmt, args.args)
  local reload_command = string.format(command_fmt, '{q}')
  local spec = string.format("{ \z
    'options': [ \z
      '--phony', \z
      '--query', '%s', \z
      '--bind', 'change:reload:%s' \z
    ] \z
  }", args.args, reload_command)

  vim.api.nvim_exec("call fzf#vim#grep('" .. initial_command .. "', 1, fzf#vim#with_preview(" .. spec .."))", true)

end, {
  nargs = "*",
  bang = true,
  desc = "LiveRipgrepFzf"
})


-- remove commands I don't use
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "delcommand Ag | delcommand Snippets",
  desc = "remove unused fzf commands"
})
