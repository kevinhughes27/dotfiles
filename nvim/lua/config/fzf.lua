local g = vim.g

-- actions
g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}
-- need quick fix too

-- preview window
g.fzf_preview_window = 'right:60%:sharp'

-- layout
if vim.fn.exists('$TMUX') == 1 then
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

-- toggle tmux layout
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
  desc = "Toggle Fzf to use a vim window. Needed for pairing to display fzf"
})

-- colors
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
  header =  {'fg', 'Comment'},
}
g.fzf_colors['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'}
g.fzf_colors['bg+'] = {'bg', 'CursorLine', 'CursorColumn'}
g.fzf_colors['hl+'] = {'fg', 'Label'}


-- fzf
local function fzf(source, options)
  -- https://github.com/junegunn/fzf/blob/master/README-VIM.md
  local fzf_run = vim.fn["fzf#run"]
  local fzf_wrap = vim.fn["fzf#wrap"]

  -- typically fzf_wrap would setup --expects and the sinklist but
  -- it does so with an anonymous vim function which does not live
  -- outside of the first vim.fn call meaning it is undefined when
  -- we call fzf_run. Therefore we have to setup the expected keys
  -- and sinklist ourselve. fzf_wrap is still useful for the layout
  -- and colors.

  local keys = {}
  for k in pairs(g.fzf_action) do keys[#keys + 1] = k end
  options = options .. " --expect=" .. table.concat(keys, ",")

  local sinklist = function(lines)
    -- cancelled
    if next(lines) == nil then return end

    local key = lines[1]
    local file = lines[2]

    -- action if any
    local action = g.fzf_action[key]
    if action then vim.cmd(action) end

    -- open the file
    vim.cmd("e " .. file)
  end

  fzf_run(fzf_wrap({
    source = source,
    options = options,
    sinklist = sinklist
  }))
end

-- Files
vim.api.nvim_create_user_command("Files", function()
  local source = '' -- FZF_DEFAULT_COMMAND
  local options = '--preview "bat --style=numbers --color=always {}"'
  fzf(source, options)
end, {})

-- Recent Files
vim.api.nvim_exec([[
  function! _uniq(list)
    let visited = {}
    let ret = []
    for l in a:list
      if !empty(l) && !has_key(visited, l)
        call add(ret, l)
        let visited[l] = 1
      endif
    endfor
    return ret
  endfunction

  function! _recent_files()
    return _uniq(map(
      \ filter([expand('%%')], 'len(v:val)')
      \   + filter(copy(v:oldfiles), "filereadable(fnamemodify(v:val, ':p'))"),
      \ 'fnamemodify(v:val, ":~:.")'))
  endfunction
]], true)

vim.api.nvim_create_user_command("RecentFiles", function()
  local source = vim.fn["_recent_files"]()
  local options = '--prompt "Recent> " --preview "bat --style=numbers --color=always {}"'
  fzf(source, options)
end, {})

-- Rg
vim.api.nvim_create_user_command("Rg", function(args)
  local source = 'rg --hidden --glob "!.git/*" --column --line-number --color=always --smart-case -- ' .. args.args
  local options = '--ansi --delimiter : --preview "bat --style=numbers --color=always --highlight-line {2} {1}" --preview-window +{2}-/2'
  fzf(source, options)
end, { nargs = 1 })


-- RG
-- live ripgrep. fzf acts as selector only
vim.api.nvim_create_user_command("RG", function(args)
  local command_fmt = 'rg --hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  local initial_command = string.format(command_fmt, args.args)
  local reload_command = string.format(command_fmt, '{q}')

  local source = initial_command
  local options = string.format("--ansi --query '%s' --bind 'change:reload:%s'", args.args, reload_command)

  fzf(source, options)
end, { nargs = "*" })
