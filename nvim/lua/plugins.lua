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
  use 'christoomey/vim-tmux-navigator'

  -- zoom
  use 'nyngwang/NeoZoom.lua'

  -- fzf
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- test running
  use 'vim-test/vim-test'
  use 'benmills/vimux'

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

  -- auto formatting
  use 'mhartington/formatter.nvim'
  use 'McAuleyPenney/tidy.nvim'

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
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'onsails/lspkind-nvim'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'

  -- gcc and gc + motion to comment
  use 'tpope/vim-commentary'

  -- sublime style multiple cursors. ctrl-n to start
  use 'mg979/vim-visual-multi'

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
