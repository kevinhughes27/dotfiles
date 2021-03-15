----------------------- Helpers -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local execute = vim.api.nvim_command

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
  execute('!git clone https://github.com/savq/paq-nvim.git '..install_path)
end

-- init paq-nvim
cmd 'packadd paq-nvim'            -- load package
local paq = require'paq-nvim'.paq -- import module and bind `paq` function
paq {'savq/paq-nvim', opt=true}   -- let paq manage itself

------------- Plugins -------------
-- theme
paq {'joshdick/onedark.vim'}
-- icons
paq {'kyazdani42/nvim-web-devicons'}
-- statusline
paq {'hoob3rt/lualine.nvim'}
-- buffer/tab theme
paq {'romgrk/barbar.nvim'}
-- project tree
paq {'kyazdani42/nvim-tree.lua'}
-- seamless split/tmux navigation
paq {'christoomey/vim-tmux-navigator'}
-- gitgutter
paq {'airblade/vim-gitgutter'}
-- scrollbar
paq { 'dstein64/nvim-scrollview' }
-- fuzzy file open and search
-- paq {'nvim-lua/popup.nvim'} -- required
-- paq {'nvim-lua/plenary.nvim'} -- required
-- paq {'nvim-telescope/telescope.nvim'}
paq {'junegunn/fzf', hook = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
-- test running
paq {'vim-test/vim-test'}
paq {'benmills/vimux'}
-- ruby
paq {'vim-ruby/vim-ruby'}
-- syntax
paq {'sheerun/vim-polyglot'}
-- gcc and gc + motion to comment
paq {'tpope/vim-commentary' }
-- sublime style multiple cursors
paq {'mg979/vim-visual-multi'}

-- theme
cmd 'colorscheme onedark'

-- statusline
local lualine = require('lualine')
lualine.options.theme = 'onedark'
lualine.status()

-- bufferline (barbar)
g.bufferline = {
  auto_hide = 1
}
g.BufferTabpageFill = "bg"

-- settings
local indent = 2
opt('o', 'mouse', 'a')                   -- allow mouse
opt('o', 'showmatch', true)              -- highlight matching [{()}]
opt('b', 'expandtab', true)              -- use spaces instead of tabs
opt('b', 'shiftwidth', indent)           -- size of an indent
opt('b', 'smartindent', true)            -- insert indents automatically
opt('b', 'tabstop', indent)              -- number of spaces tabs count for
opt('o', 'ignorecase', true)             -- ignore case
opt('o', 'smartcase', true)              -- don't ignore case with capitals
opt('o', 'splitbelow', true)             -- put new windows below current
opt('o', 'splitright', true)             -- put new windows right of current
opt('o', 'termguicolors', true)          -- true color support
opt('w', 'list', true)                   -- show some invisible characters (tabs...)
opt('w', 'number', true)                 -- print line number
opt('w', 'wrap', false)                  -- disable line wrap
opt('o', 'updatetime', 100)              -- otherwise git status in gitgutter is rather delayed

-- mappings
map('i', 'jk', '<ESC>') -- https://danielmiessler.com/study/vim/
map('n', '<C-\\>', ':vsplit<CR>') -- in my head this is C-|
map('n', '<C-_>', ':split<CR>')

-- tree
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_indent_markers = 1
g.nvim_tree_auto_open = 1 -- opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_close = 1 -- closes the tree when it's the last window
g.nvim_tree_follow = 1 -- tree focuses on the current file
map('n', '<C-b>', ':NvimTreeToggle<Cr>')

-- fzf
g.fzf_layout = {
  window = {
    width = 1.0,
    height = 1.0,
    border = 'none'
  }
}
g.fzf_preview_window = 'down:80%'
g.fzf_colors = {
  fg =      {'fg', 'Normal'},
  bg =      {'bg', 'Normal'},
  hl =      {'fg', 'Label'},
  info =    {'fg', 'Comment'},
  border =  {'fg', 'Ignore'},
  prompt =  {'fg', 'Function'},
  pointer = {'fg', 'Statement'},
  marker =  {'fg', 'Conditional'},
  spinner = {'fg', 'Label'},
  header =  {'fg', 'Comment'}
}
g.fzf_colors['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'}
g.fzf_colors['bg+'] = {'bg', 'CursorLine', 'CursorColumn'}
g.fzf_colors['hl+'] = {'fg', 'Label'}

map('n', '<C-p>', ':Files<Cr>')
map('n', '<C-h>', ':History<Cr>')
map('n', '<C-f>', ':Rg<Cr>')

-- telescope
-- require("telescope").setup {
--   defaults = {
--     layout_strategy = "vertical",
--     layout_defaults = {
--       vertical = {
--         mirror = true,
--         width_padding = 1,
--         height_padding = 1
--       }
--     },
--   }
-- }
-- map('n', '<C-p>', ':Telescope find_files<Cr>')
-- map('n', '<C-h>', ':Telescope oldfiles<Cr>')
-- map('n', '<C-f>', ':Telescope live_grep<Cr>')

-- tmux
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_save_on_switch = 2
map('n', '<C-Left>',  ':TmuxNavigateLeft<cr>')
map('n', '<C-Down>',  ':TmuxNavigateDown<cr>')
map('n', '<C-Up>',    ':TmuxNavigateUp<cr>')
map('n', '<C-Right>', ':TmuxNavigateRight<cr>')

-- vim-test / vimux
g['test#strategy'] = "vimux" -- make test commands execute using vimux
g['VimuxUseNearest'] = 0 -- don't use an exisiting pane
map('n', '<C-t>', ':w<CR> :TestFile<CR>')
map('n', '<C-l>', ':w<CR> :TestNearest<CR>')
map('n', '<C-s>', ':w<CR> :TestLast<CR>')


----------------------- References ----------------------------
-- https://oroques.dev/notes/neovim-init/
-- https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
-- https://github.com/siduck76/neovim-dots
