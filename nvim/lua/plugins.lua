------------------ Bootstrap ------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

------------------- Plugins -------------------
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- theme
  use 'navarasu/onedark.nvim'

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- statusline
  use 'nvim-lualine/lualine.nvim'

  -- project tree
  use 'kyazdani42/nvim-tree.lua'

  -- dim inactive panes
  -- breaks LSP documentation https://github.com/sunjon/Shade.nvim/issues/25
  -- use 'sunjon/Shade.nvim'

  -- smart relative vs absolute line numbering
  use 'jeffkreeftmeijer/vim-numbertoggle'

  -- gitsigns
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- github link copy :GH
  use 'ruanyl/vim-gh-line'

  -- seamless split/tmux navigation
  use 'christoomey/vim-tmux-navigator'

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
        }
      })
    end
  }

  -- auto formatting
  use 'mhartington/formatter.nvim'
  use 'McAuleyPenney/tidy.nvim'

  -- lsp and snippets
  use 'L3MON4D3/LuaSnip'
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'

  -- gcc and gc + motion to comment
  use 'tpope/vim-commentary'

  -- sublime style multiple cursors. ctrl-n to start
  use 'mg979/vim-visual-multi'

  -- navigation training
  use 'tjdevries/train.nvim'

  -- automatically sync after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
