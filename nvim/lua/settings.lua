-- Settings
--
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

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
opt('o', 'signcolumn','yes')          -- always shown signcolumn
opt('o', 'undofile', true)            -- enable undofile
opt('o', 'updatetime', 100)           -- update frequency

-- copy into clipboard by default
local os = vim.fn.substitute(vim.fn.system('uname'), '\n', '', '')

if os == 'Darwin' then
  opt('o', 'clipboard', 'unnamed')
else
  opt('o', 'clipboard', 'unnamedplus')
end

-- Mappings
--
local map = vim.keymap.set

-- gimme ctrl s
map('n', '<C-s>', ':w<CR>', {})
map('i', '<C-s>', '<ESC>:w<CR>', {})

-- clear highlight
map('n', '<ESC>', ':noh<CR>', {silent = true})

-- dont lose selection when shifting sideways
-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
map('x', '<', '<gv')
map('x', '>', '>gv')

-- smart_dd
-- https://www.reddit.com/r/neovim/comments/w0jzzv/smart_dd/
function Smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end
map('n', 'dd', Smart_dd, {expr = true})
