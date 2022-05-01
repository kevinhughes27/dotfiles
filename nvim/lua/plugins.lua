-- Bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

-- Plugins
return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  -- theme
  use 'navarasu/onedark.nvim'

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- statusline
  use 'nvim-lualine/lualine.nvim'

  -- tabline
  use 'rafcamlet/tabline-framework.nvim'

  -- project tree
  use 'kyazdani42/nvim-tree.lua'

  -- smart relative vs absolute line numbering
  use 'jeffkreeftmeijer/vim-numbertoggle'

  -- fancy menu
  use { 'gelguy/wilder.nvim', run = ':UpdateRemotePlugins' }

  -- gitsigns
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- github link copy :GH
  use 'ruanyl/vim-gh-line'

  -- seamless split/tmux navigation
  use {
    'christoomey/vim-tmux-navigator',
    config = function ()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end
  }

  -- remember cursor position
  use {
    'farmergreg/vim-lastplace',
    config = function()
      vim.g.lastplace_ignore_buftype = "quickfix,nofile,help,NvimTree"
    end
  }

  -- zoom
  use 'nyngwang/NeoZoom.lua'

  -- fzf
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- test running
  use 'benmills/vimux'
  use {
    'vim-test/vim-test',
    config = function ()
      vim.g['test#strategy'] = 'vimux' -- make test commands execute using vimux
      vim.g['VimuxUseNearest'] = 0 -- don't use an exisiting pane
      vim.g['VimuxHeight'] = '25'
    end
  }

  -- syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
          },
        },
      })
    end
  }

  -- highlight urls
  use 'itchyny/vim-highlighturl'

  -- snippets
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = { '~/dotfiles/nvim/snippets' }
      })
    end
  }

  -- lsp
  use {
    'junnplus/nvim-lsp-setup',
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
    }
  }
  use 'folke/lua-dev.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- auto formatting
  use 'McAuleyPenney/tidy.nvim'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind-nvim'

  -- gcc and gc + motion to comment
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
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
