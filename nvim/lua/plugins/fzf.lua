local fzf = require('fzf-lua')
local actions = require('fzf-lua.actions')

fzf.setup({
  'border-fused',
  fzf_opts = {
    ['--tmux'] = 'center,90%,92%',
    ['--border'] = 'rounded'
  },
  winopts = {
    preview = {
      default = 'bat',
      layout = 'horizontal'
    }
  },
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

vim.keymap.set('n', '<C-p>', ':FzfLua files<CR>', { silent = true })
vim.keymap.set('n', '<C-h>', ':FzfLua oldfiles<CR>', { silent = true })
vim.keymap.set('n', '<C-f>', ':FzfLua grep_cword<CR>', { silent = true })
