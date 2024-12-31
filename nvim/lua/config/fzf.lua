-- fzf
local fzf = require('fzf-lua')
local actions = require('fzf-lua.actions')

fzf.setup({
  fzf_bin = 'fzf-tmux',
  fzf_opts = { ['--border'] = 'rounded' },
  fzf_tmux_opts = { ['-p'] = '90%,90%' },
  winopts = { preview = { default = 'bat', layout = 'horizontal' } },
  oldfiles = {
    cwd_only = true,
    stat_file = true, -- verify files exist on disk
    include_current_session = true, -- include bufs from current session
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --hidden --color=always --smart-case --max-columns=4096 -e", -- defaults + hidden
  },
  actions = {
    files = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-s']  = actions.file_split,
      ['ctrl-h']  = actions.file_vsplit,
      ['ctrl-t']  = actions.file_tabedit,
    },
  },
})
