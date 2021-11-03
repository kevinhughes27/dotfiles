----------------------- Helpers -------------------------------
local fn = vim.fn    -- to call vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- auto install paq-nvim if necessary
local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/savq/paq-nvim.git '..install_path)
end

-- init paq-nvim
vim.cmd('packadd paq-nvim')         -- load package
local paq = require('paq-nvim').paq -- import module and bind `paq` function
paq {'savq/paq-nvim', opt=true}     -- let paq manage itself

------------- Plugins -------------
-- theme
paq {'navarasu/onedark.nvim'}

-- dim inactive panes
paq {'sunjon/Shade.nvim'}

-- focus current block
paq {'folke/twilight.nvim'}

-- icons
paq {'kyazdani42/nvim-web-devicons'}

-- statusline
paq {'nvim-lualine/lualine.nvim'}

-- project tree
paq {'kyazdani42/nvim-tree.lua'}

-- navigation training
paq {'tjdevries/train.nvim'}

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

-- completion
paq {'hrsh7th/nvim-cmp'}
paq {'hrsh7th/cmp-path'}
paq {'hrsh7th/cmp-buffer'}
paq {'hrsh7th/cmp-nvim-lsp'}
paq {'saadparwaiz1/cmp_luasnip'}

paq {'L3MON4D3/LuaSnip'}
paq {'neovim/nvim-lspconfig'}
paq {'onsails/lspkind-nvim'}

-- gcc and gc + motion to comment
paq {'tpope/vim-commentary' }

-- sublime style multiple cursors. ctrl-n to start
paq {'mg979/vim-visual-multi'}

-- settings
local indent = 2
opt('o', 'mouse', 'a')                -- allow mouse
opt('o', 'showmatch', true)           -- highlight matching [{()}]
opt('b', 'expandtab', true)           -- use spaces instead of tabs
opt('b', 'shiftwidth', indent)        -- size of an indent
opt('b', 'smartindent', true)         -- insert indents automatically
opt('b', 'tabstop', indent)           -- number of spaces tabs count for
opt('o', 'ignorecase', true)          -- ignore case
opt('o', 'smartcase', true)           -- don't ignore case with capitals
opt('o', 'splitbelow', true)          -- put new windows below current
opt('o', 'splitright', true)          -- put new windows right of current
opt('o', 'termguicolors', true)       -- true color support
opt('w', 'list', true)                -- show some invisible characters (tabs...)
opt('w', 'number', true)              -- print line number
opt('w', 'wrap', false)               -- disable line wrap
opt('o', 'updatetime', 100)           -- update frequency

-- copy into clipboard by default
local os = fn.substitute(fn.system('uname'), '\n', '', '')
if os == 'Darwin' then
  opt('o', 'clipboard', 'unnamed')
else
  opt('o', 'clipboard', 'unnamedplus')
end

-- colors
require('onedark').setup()

-- disable dark sidebar
local c = require('onedark.colors')
vim.cmd('highlight NvimTreeNormal guibg=' .. c.bg0)
vim.cmd('highlight NvimTreeEndOfBuffer guibg=' .. c.bg0)

-- set pmenu highlight to green
vim.api.nvim_command('autocmd BufEnter * hi PmenuSel guibg=' .. c.green)

-- icons
require('nvim-web-devicons').setup({
  override = {
    rb = {
      icon = '',
      color = '#e06c75',
      name = 'Rb'
    },
    erb = {
      icon = '',
      color = '#e06c75',
      name = 'Erb',
    },
    rake = {
      icon = '',
      color = '#e06c75',
      name = 'Rake'
    },
    ['config.ru'] = {
      icon = '',
      color = '#e06c75',
      name = 'ConfigRu'
    },
    sqlite3 = {
      icon = '',
      color = '#dad8d8',
      name = 'sqlite',
    };
  };
})

require('shade').setup({
  overlay_opacity = 75,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>s',
  }
})

-- statusline
require('lualine').setup({
  options = {
    theme = 'onedark',
    disabled_filetypes = {'NvimTree'}
  },
  sections = {
    lualine_a = { {'mode', upper = true} },
    lualine_b = { {'branch', icon = ''} },
    lualine_c = { {'filename', file_status = true} },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

-- treesitter
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  }
})

-- mappings
map('i', 'jk', '<ESC>') -- https://danielmiessler.com/study/vim/
map('n', '<ESC>', ':noh|set norelativenumber!<CR>') -- clear highlight and toggle relative numbers

-- new splits
map('n', '<C-\\>', ':vsplit<CR>') -- in my head this is C-| (pipe)
map('n', '<C-_>', ':split<CR>')

-- resize vertical splits
map('n', '=', ':exe "vertical resize " . (winwidth(0) * 9/8)<CR>') -- in my head this is `+`
map('n', '-', ':exe "vertical resize " . (winwidth(0) * 7/8)<CR>')

-- tab for tabs
map('n', '<Tab>', ':tabnext<CR>')

-- gimme ctrl s
map('n', '<C-s>', ':w<CR>')
map('i', '<C-s>', '<ESC>:w<CR>i')

-- disable visual-multi-mappings (it binds to ctrl up/down which I use for navigation)
g.VM_default_mappings = 0

-- tmux navigation
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_save_on_switch = 2
map('n', '<C-Left>',  ':TmuxNavigateLeft<CR>',  {silent = true})
map('n', '<C-Down>',  ':TmuxNavigateDown<CR>',  {silent = true})
map('n', '<C-Up>',    ':TmuxNavigateUp<CR>',    {silent = true})
map('n', '<C-Right>', ':TmuxNavigateRight<CR>', {silent = true})

-- vim-test / vimux
g['test#strategy'] = 'vimux' -- make test commands execute using vimux
g['VimuxUseNearest'] = 0 -- don't use an exisiting pane
g['VimuxHeight'] = '20'
map('n', '<C-t>', ':w<CR> :TestFile<CR>')
map('n', '<C-l>', ':w<CR> :TestNearest<CR>')

-- overmind connect in a tmux popup
vim.api.nvim_exec([[
command! -nargs=1 Oc :silent !tmux popup -E -d $(pwd) -h 80\% -w 80\% overmind connect <f-args>
]], true)

-- remember last cursor position (ignore tree)
require('cursor')

-- formatting
require('formatting')

-- code completion
require('lsp')
require('completion')

-- nvim-tree
require('tree')
map('n', '<C-b>', ':NvimTreeFindFileToggle<CR>')

-- fzf
require('fzf')
map('n', '<C-p>', ':Files<CR>')
map('n', '<C-h>', ':History<CR>')
map('n', '<C-f>', ':RG <C-R><C-W><CR>', {silent = true})

----------------------- References ----------------------------
-- https://oroques.dev/notes/neovim-init/
-- https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
-- https://github.com/siduck76/neovim-dots
-- https://github.com/mjlbach/defaults.nvim
