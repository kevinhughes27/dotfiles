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
opt('b', 'smartindent', false)        -- insert indents automatically
opt('b', 'tabstop', indent)           -- number of spaces tabs count for
opt('o', 'ignorecase', true)          -- ignore case
opt('o', 'smartcase', true)           -- don't ignore case with capitals
opt('o', 'splitbelow', true)          -- put new windows below current
opt('o', 'splitright', true)          -- put new windows right of current
opt('o', 'termguicolors', true)       -- true color support
opt('o', 'background', 'dark')        -- set the background as dark
opt('w', 'list', true)                -- show some invisible characters (tabs...)
opt('w', 'number', true)              -- print line number
opt('w', 'wrap', false)               -- disable line wrap
opt('o', 'signcolumn', 'yes')         -- always show signcolumn
opt('o', 'foldcolumn', '1')           -- always show foldcolumn
opt('o', 'undofile', true)            -- enable undofile
opt('o', 'updatetime', 100)           -- update frequency

-- copy into clipboard by default
local os = vim.fn.substitute(vim.fn.system('uname'), '\n', '', '')

if os == 'Darwin' then
  opt('o', 'clipboard', 'unnamed')
else
  opt('o', 'clipboard', 'unnamedplus')
end

-- fold settings
opt('o', 'fillchars', 'fold: ,foldopen:,foldsep: ,foldclose:')
function _G.custom_fold_text()
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line_count .. " lines"
end
vim.opt.foldtext = 'v:lua.custom_fold_text()'

-- disable builtins
-- they will still show in a --startuptime output but the times will be much faster
-- because it is short-circuited to not load here
local builtins = {
  'gzip',
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'logiPat',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'rrhelper',
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in ipairs(builtins) do
  vim.g['loaded_' .. plugin] = 1
end
