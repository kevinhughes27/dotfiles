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

function _G.FzfTmuxToggle()
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
end

vim.api.nvim_exec([[
command! FzfTmuxToggle :lua FzfTmuxToggle()
]], true)

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
vim.api.nvim_exec(
[[
function RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --glob "!.git/*" --ignore-file ~/dotfiles/fzf-ignore --column --line-number --no-heading --color=always --smart-case -- %s'
  let command = printf(command_fmt, shellescape(a:query))
  call fzf#vim#grep(command, 1, fzf#vim#with_preview(), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
]],
true)

-- live ripgrep fzf acts as selector only
vim.api.nvim_exec(
[[
function! LiveRipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call LiveRipgrepFzf(<q-args>, <bang>0)
]],
true)
