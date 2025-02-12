-- Plugins
--
return {

  -- lua utils
  {'nvim-lua/plenary.nvim'},

  -- highlight urls
  {'itchyny/vim-highlighturl'},

  -- neovim
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {},
  },

  -- remote copy
  {
    'ojroques/nvim-osc52',
    config = function()
      require('osc52').setup({ silent = true, tmux_passthrough = true })
    end
  },

  -- remember cursor position
  {
    'vladdoster/remember.nvim',
    config = function()
      require('remember')
    end
  },

  -- sublime style multiple cursors. ctrl-n to start
  {
    'mg979/vim-visual-multi',
    init = function()
      -- disable visual-multi-mappings
      -- (it binds to ctrl up/down which I use for navigation)
      vim.g.VM_default_mappings = 0
    end,
    lazy = true,
    keys = {
      { '<C-n>', ':call g:VM_maps["Find Under"][1]', mode = {'n', 'v'}}
    },
  },
}
