-- Bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })

  vim.cmd [[packadd packer.nvim]]
end

local function get_config(name)
  return string.format('require("config/%s")', name)
end

-- Plugins
return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

  -- lua utils
  use 'nvim-lua/plenary.nvim'

  -- theme
  use 'navarasu/onedark.nvim'

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    config = get_config('lualine'),
  }

  -- tabline
  use {
    'rafcamlet/tabline-framework.nvim',
    config = get_config('tabline'),
  }

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    config = get_config('nvim-tree'),
  }

  -- gitsigns
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  }

  -- github link copy :GH
  use 'ruanyl/vim-gh-line'

  -- highlight urls
  use 'itchyny/vim-highlighturl'

  -- seamless split/tmux navigation
  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end
  }

  -- smart split resize
  use {
    'mrjones2014/smart-splits.nvim',
    config = function() require('smart-splits').setup({}) end
  }

  -- fzf
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf' },
    config = get_config('fzf'),
  }

  -- test running
  use 'benmills/vimux'
  use {
    'vim-test/vim-test',
    config = function()
      vim.g['test#strategy'] = 'vimux' -- make test commands execute using vimux
      vim.g['test#python#runner'] = 'pytest' -- have to configure which python runner to use https://github.com/vim-test/vim-test#python
      vim.g['VimuxUseNearest'] = 0 -- don't use an exisiting pane
      vim.g['VimuxHeight'] = '25'
    end
  }

  -- syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/playground' },
    config = get_config('treesitter')
  }

  -- lsp
  use {
    'junnplus/nvim-lsp-setup',
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'folke/lua-dev.nvim',
    },
    config = get_config('lsp')
  }

  -- snippets
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = { '~/dotfiles/nvim/snippets' }
      })
    end
  }

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
    config = get_config('nvim-cmp'),
  }

  -- gcc and gc + motion to comment
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }

  -- remember cursor position
  use {
    'farmergreg/vim-lastplace',
    config = function()
      vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help,NvimTree'
    end
  }

  -- autolist - starts new list items automatically in markdown
  use {
    'gaoDean/autolist.nvim',
     config = function() require('autolist').setup() end
  }

  -- sublime style multiple cursors. ctrl-n to start
  use {
    'mg979/vim-visual-multi',
    config = function()
      -- disable visual-multi-mappings
      -- (it binds to ctrl up/down which I use for navigation)
      vim.g.VM_default_mappings = 0
    end
  }

  -- automatically sync after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
