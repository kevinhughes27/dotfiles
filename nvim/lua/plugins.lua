-- auto install paq-nvim if necessary
local install_path = vim.fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/savq/paq-nvim.git '..install_path)
end

-- init paq-nvim
vim.cmd('packadd paq-nvim')         -- load package
local paq = require('paq-nvim').paq -- import module and bind `paq` function
paq {'savq/paq-nvim', opt=true}     -- let paq manage itself

------------- Plugins -------------

-- theme
paq {'navarasu/onedark.nvim'}

-- icons
paq {'kyazdani42/nvim-web-devicons'}

-- statusline
paq {'nvim-lualine/lualine.nvim'}

-- project tree
paq {'kyazdani42/nvim-tree.lua'}

-- dim inactive panes
-- breaks LSP documentation https://github.com/sunjon/Shade.nvim/issues/25
-- paq {'sunjon/Shade.nvim'}

-- smart relative vs absolute line numbering
paq {'jeffkreeftmeijer/vim-numbertoggle'}

-- gitgutter
paq {'airblade/vim-gitgutter'}

-- github link copy :GH
paq { 'ruanyl/vim-gh-line' }

-- seamless split/tmux navigation
paq {'christoomey/vim-tmux-navigator'}

-- fzf
paq {'junegunn/fzf'}
paq {'junegunn/fzf.vim'}

-- test running
paq {'vim-test/vim-test'}
paq {'benmills/vimux'}

-- syntax highlighting
paq {'nvim-treesitter/nvim-treesitter'}

-- auto formatting
paq {'mhartington/formatter.nvim'}
paq {'McAuleyPenney/tidy.nvim'}

-- completion
paq {'hrsh7th/nvim-cmp'}
paq {'hrsh7th/cmp-path'}
paq {'hrsh7th/cmp-buffer'}
paq {'hrsh7th/cmp-nvim-lsp'}
paq {'saadparwaiz1/cmp_luasnip'}

-- lsp and snippets
paq {'L3MON4D3/LuaSnip'}
paq {'neovim/nvim-lspconfig'}
paq {'onsails/lspkind-nvim'}

-- gcc and gc + motion to comment
paq {'tpope/vim-commentary' }

-- sublime style multiple cursors. ctrl-n to start
paq {'mg979/vim-visual-multi'}

-- navigation training
paq {'tjdevries/train.nvim'}
