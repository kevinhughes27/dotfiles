local g = vim.g
local fn = vim.fn

g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

-- need quick fix too

-- layout
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
  desc = "Toggle Fzf to use a vim window. Needed for pairing to display fzf"
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
  header =  {'fg', 'Comment'},
}

-- would be nice to define these all the same
g.fzf_colors['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'}
g.fzf_colors['bg+'] = {'bg', 'CursorLine', 'CursorColumn'}
g.fzf_colors['hl+'] = {'fg', 'Label'}

-- fzf
-- source: can be a vim function or shell escaped string
-- options: shell escaped string
-- https://github.com/junegunn/fzf/blob/master/README-VIM.md
local function fzf(source, options)
  local vimscript = string.format([[
    call fzf#run(fzf#wrap({'source': %s, 'options': '%s'}))
  ]], source, options)

  vim.api.nvim_exec(vimscript, true)
end

-- Files
vim.api.nvim_create_user_command("Files", function()
  local source = vim.fn.shellescape('') -- FZF_DEFAULT_COMMAND
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
  local source = '_recent_files()'
  local options = '--prompt "Recent> " --preview "bat --style=numbers --color=always {}"'
  fzf(source, options)
end, {})

-- Rg
vim.api.nvim_create_user_command("Rg", function(args)
  local source = vim.fn.shellescape('rg --hidden --glob "!.git/*" --column --line-number --color=always --smart-case -- ' .. args.args)
  local options = '--ansi --delimiter : --preview "bat --style=numbers --color=always --highlight-line {2} {1}" --preview-window +{2}-/2'
  fzf(source, options)
end, { nargs = 1 })


-- live ripgrep fzf acts as selector only
vim.api.nvim_create_user_command("RG", function(args)
  -- can't ignore git until I figure out how to call fzf#run without nvim_exec because I need both types of quotes available to me
  -- --glob "!.git/*"
  local command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
  local initial_command = string.format(command_fmt, args.args)
  local reload_command = string.format(command_fmt, '{q}')

  local source = vim.fn.shellescape(initial_command)
  local options = string.format('--ansi --query "%s" --bind "change:reload:%s"', args.args, reload_command)

  fzf(source, options)
end, { nargs = "*" })
