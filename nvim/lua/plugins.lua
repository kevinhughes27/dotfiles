-- Plugins

-- bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- lua utils
  {'nvim-lua/plenary.nvim'},

  -- theme
  {
    'navarasu/onedark.nvim',
    priority=1000,
    config = function() require('config/onedark') end,
  },

  -- icons
  {
    'kyazdani42/nvim-web-devicons',
    config = function() require('config/nvim-web-devicons') end,
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('config/lualine') end,
  },

  -- tabline
  {
    'rafcamlet/tabline-framework.nvim',
    config = function() require('config/tabline') end,
  },

  -- file tree
  {
    'kyazdani42/nvim-tree.lua',
    config = function() require('config/nvim-tree') end,
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end,
  },

  -- remote copy
  {
    'ojroques/nvim-osc52',
    config = function()
      require('osc52').setup({ silent = true })
    end
  },

  -- github link copy :GH
  {
    'ruifm/gitlinker.nvim',
    dependencies = { 'preservim/vimux' },
  },

  -- highlight urls
  {'itchyny/vim-highlighturl'},

  -- autolist
  {
    'gaoDean/autolist.nvim',
    config = function() require('autolist').setup({}) end,
  },

  -- seamless split/tmux navigation
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end
  },

  -- smart split resize
  {
    'mrjones2014/smart-splits.nvim',
    config = function() require('smart-splits').setup({}) end,
  },

  -- fzf
  {
    'junegunn/fzf',
    config = function() require('config/fzf') end,
  },

  -- test running
  {
    'vim-test/vim-test',
    dependencies = { 'preservim/vimux' },
    config = function()
      vim.g['test#strategy'] = 'vimux'       -- make test commands execute using vimux
      vim.g['test#python#runner'] = 'pytest' -- have to configure which python runner to use https://github.com/vim-test/vim-test#python
      vim.g['VimuxUseNearest'] = 0           -- don't use an exisiting pane
      vim.g['VimuxHeight'] = '25'
    end
  },

  -- syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('config/treesitter') end,
  },

  -- lsp
  {
    'junnplus/nvim-lsp-setup',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'folke/neodev.nvim',
    },
    config = function() require('config/lsp') end,
  },

  -- null-ls (formatting)
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function() require('config/null-ls') end,
  },

  -- snippets
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = { '~/dotfiles/nvim/snippets' }
      })
    end
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
    config = function() require('config/nvim-cmp') end,
  },

  -- gcc and gc + motion to comment
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  },

  -- remember cursor position
  {
    'farmergreg/vim-lastplace',
    config = function()
      vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help,NvimTree'
    end
  },

  -- sublime style multiple cursors. ctrl-n to start
  {
    'mg979/vim-visual-multi',
    config = function()
      -- disable visual-multi-mappings
      -- (it binds to ctrl up/down which I use for navigation)
      vim.g.VM_default_mappings = 0
    end
  },
},
-- lazy opts
{})
