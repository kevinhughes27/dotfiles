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

-- project tree
paq {'kyazdani42/nvim-tree.lua'}

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

-- syntax
paq {'sheerun/vim-polyglot'}
paq {'vim-ruby/vim-ruby'}

-- completion
paq {'hrsh7th/nvim-compe'}
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

-- onedark.vim override:
-- don't set a background color just use the terminal's background color
-- set pmenu highlight to green
execute('autocmd ColorScheme * call onedark#set_highlight("Normal", {})')
execute('autocmd BufEnter * hi PmenuSel guibg=#98c379')

-- colors
cmd('colorscheme onedark')

-- icons
require('nvim-web-devicons').setup({
  override = {
    rb = {
      icon = "",
      color = "#e06c75",
      name = "Rb"
    },
    erb = {
      icon = "",
      color = "#e06c75",
      name = "Erb",
    },
    rake = {
      icon = "",
      color = "#e06c75",
      name = "Rake"
    },
    ["config.ru"] = {
      icon = "",
      color = "#e06c75",
      name = "ConfigRu"
    },
    sqlite3 = {
      icon = "",
      color = "#dad8d8",
      name = "sqlite",
    };
  };
})

-- statusline
require('lualine').setup({
  options = {
    theme = 'onedark'
  },
  sections = {
    lualine_a = { {'mode', upper = true} },
    lualine_b = { {'branch', icon = ''} },
    lualine_c = { {'filename', file_status = true} },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  extensions = { 'nvim-tree' }
})

-- copy into clipboard by default
local os = fn.substitute(fn.system('uname'), '\n', '', '')
if os == 'Darwin' then
  opt('o', 'clipboard', 'unnamed')
else
  opt('o', 'clipboard', 'unnamedplus')
end

-- mappings
map('i', 'jk', '<ESC>') -- https://danielmiessler.com/study/vim/

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

-- strip trailing spaces on save
execute('autocmd BufWritePre * :%s/\\s\\+$//e')

-- tmux
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_save_on_switch = 2
map('n', '<C-Left>',  ':TmuxNavigateLeft<cr>',  {silent = true})
map('n', '<C-Down>',  ':TmuxNavigateDown<cr>',  {silent = true})
map('n', '<C-Up>',    ':TmuxNavigateUp<cr>',    {silent = true})
map('n', '<C-Right>', ':TmuxNavigateRight<cr>', {silent = true})

-- disable visual-multi-mappings
-- it binds to ctrl up/down which I use for navigation
g.VM_default_mappings = 0

-- vim-test / vimux
g['test#strategy'] = 'vimux' -- make test commands execute using vimux
g['VimuxUseNearest'] = 0 -- don't use an exisiting pane
g['VimuxHeight'] = '20'
map('n', '<C-t>', ':w<CR> :TestFile<CR>')
map('n', '<C-l>', ':w<CR> :TestNearest<CR>')

-- code completion
require('completion-config')
map('i', '<Tab>', 'v:lua.tab_complete()', {silent = true, expr = true})
map('s', '<Tab>', 'v:lua.tab_complete()', {silent = true, expr = true})
map('i', '<CR>', 'compe#confirm("<CR>")',  {silent = true, expr = true})

-- nvim-tree
require('tree-config')
map('n', '<C-b>', ':call ToggleTree()<Cr>')

-- fzf
require('fzf-config')
map('n', '<C-p>', ':Files<Cr>')
map('n', '<C-o>', ':Buffers<Cr>')
map('n', '<C-h>', ':History<Cr>')
map('n', '<C-f>', ':RG <C-R><C-W><CR>', {silent = true})

----------------------- References ----------------------------
-- https://oroques.dev/notes/neovim-init/
-- https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
-- https://github.com/siduck76/neovim-dots
