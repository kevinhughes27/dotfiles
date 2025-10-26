return {
  {
    'ibhagwan/fzf-lua',
    lazy = false,
    keys = {
      { '<C-p>', ':FzfLua files<CR>' },
      { '<C-h>', ':FzfLua oldfiles<CR>' },
      { '<C-f>', ':FzfLua grep_cword<CR>' },
    },
    config = function()
      local fzf = require('fzf-lua')
      local actions = require('fzf-lua.actions')

      fzf.setup({
        'fzf-native',
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
    end
  },
}
