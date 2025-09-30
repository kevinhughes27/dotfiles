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

  -- smartyank
  {
    'ibhagwan/smartyank.nvim',
    config = function()
      require('smartyank').setup({
        highlight = {
          enabled = true,
          higroup = 'YankPost',
          timeout = 500,
        },
        osc52 = {
          enabled = true,
          escseq = 'tmux'
        }
      })
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

      -- fix overwriting a mapping issue with blink.cmp
      -- https://github.com/Saghen/blink.cmp/issues/406
      vim.g.VM_maps = {
        ["I Return"] = "<S-CR>",
      }
    end,
    lazy = true,
    keys = {
      { '<C-n>', ':call g:VM_maps["Find Under"][1]', mode = {'n', 'v'}}
    },
  },
}
