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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
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
paq {'junegunn/fzf', hook = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
-- test running
paq {'vim-test/vim-test'}
paq {'benmills/vimux'}
-- ruby
paq {'vim-ruby/vim-ruby'}
-- syntax
paq {'sheerun/vim-polyglot'}
-- code completion
paq {'neoclide/coc.nvim', branch = 'release'}
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
vim.api.nvim_command("autocmd ColorScheme *  call onedark#set_highlight(\"Normal\", {})")

-- colors
cmd 'colorscheme onedark'

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

-- strip trailing spaces on save
vim.api.nvim_command("autocmd BufWritePre * :%s/\\s\\+$//e")

-- copy into clipboard by default
local os = fn.substitute(fn.system('uname'), '\n', '', '')
if os == 'Darwin' then
  opt('o', 'clipboard', 'unnamed')
else
  opt('o', 'clipboard', 'unnamedplus')
end

-- disable visual-multi-mappings
-- it binds to ctrl up/down which I use for navigation
g.VM_default_mappings = 0

-- mappings
map('i', 'jk', '<ESC>') -- https://danielmiessler.com/study/vim/

-- new splits
map('n', '<C-\\>', ':vsplit<CR>') -- in my head this is C-| (pipe)
map('n', '<C-_>', ':split<CR>')

-- resize vertical splits
map('n', '=', ':exe "vertical resize " . (winwidth(0) * 9/8)<CR>') -- in my head this is `+`
map('n', '-', ':exe "vertical resize " . (winwidth(0) * 7/8)<CR>')

-- tab for tabs
map('n', '<tab>', ':tabnext<CR>')

-- gimme ctrl s
map('n', '<C-s>', ':w<CR>')

-- tmux
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_save_on_switch = 2
map('n', '<C-Left>',  ':TmuxNavigateLeft<cr>', {silent = true})
map('n', '<C-Down>',  ':TmuxNavigateDown<cr>', {silent = true})
map('n', '<C-Up>',    ':TmuxNavigateUp<cr>', {silent = true})
map('n', '<C-Right>', ':TmuxNavigateRight<cr>', {silent = true})

-- vim-test / vimux
g['test#strategy'] = "vimux" -- make test commands execute using vimux
g['VimuxUseNearest'] = 0 -- don't use an exisiting pane
g['VimuxHeight'] = "30" -- default is 20
map('n', '<C-t>', ':w<CR> :TestFile<CR>')
map('n', '<C-l>', ':w<CR> :TestNearest<CR>')

-- code completion
local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
  else
      return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
  elseif check_back_space() then
      return t "<Tab>"
  else
      return vim.fn["coc#refresh"]()
  end
end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})

-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
vim.api.nvim_exec(
[[
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]],
true)

-- nvim-tree
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_width = 30
g.nvim_tree_indent_markers = 1

-- Remove all default bindings.
require'nvim-tree.view'.View.bindings = {}
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- Add back most of the detaul bindings
-- but not `-` which I use to resize splits
g.nvim_tree_bindings = {
  ["<CR>"]           = tree_cb("edit"),
  ["<2-LeftMouse>"]  = tree_cb("edit"),
  ["<2-RightMouse>"] = tree_cb("cd"),
  ["<C-x>"]          = tree_cb("split"),
  ["<C-z>"]          = tree_cb("vsplit"),
  ["<C-t>"]          = tree_cb("tabnew"),
  ["R"]              = tree_cb("refresh"),
  ["a"]              = tree_cb("create"),
  ["d"]              = tree_cb("remove"),
  ["r"]              = tree_cb("rename"),
  ["<C-r>"]          = tree_cb("full_rename"),
  ["x"]              = tree_cb("cut"),
  ["c"]              = tree_cb("copy"),
  ["p"]              = tree_cb("paste"),
  ["q"]              = tree_cb("close"),
}

-- sync the tree but only on open
map('n', '<C-b>', ':call ToggleTree()<Cr>')
vim.api.nvim_exec(
[[
function! IsTreeOpen()
  return bufwinnr('NvimTree') != -1
endfunction

function! ToggleTree()
  if IsTreeOpen()
    NvimTreeClose
  else
    NvimTreeClose
    NvimTreeFindFile
  endif
endfunction
]],
true)

-- fzf
g.fzf_layout = {
  window = {
    width = 0.8,
    height = 0.9,
  }
}
g.fzf_preview_window = 'right:60%:sharp'
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
map('n', '<C-o>', ':Buffers<Cr>')
map('n', '<C-h>', ':History<Cr>')

----------------------- References ----------------------------
-- https://oroques.dev/notes/neovim-init/
-- https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
-- https://github.com/siduck76/neovim-dots
