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

-- fold settings
opt('o', 'fillchars', 'fold: ,foldopen:,foldsep: ,foldclose:')
function _G.custom_fold_text()
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line_count .. " lines"
end
vim.opt.foldtext = 'v:lua.custom_fold_text()'

-- keymaps
local map = vim.keymap.set

-- gimme ctrl s
map('n', '<C-s>', ':w<CR>', {})
map('i', '<C-s>', '<ESC>:w<CR>', {})

-- dont lose selection when shifting sideways
-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
map('x', '<', '<gv')
map('x', '>', '>gv')

-- clear highlight + drop any multicursors
-- (built-in <C-L> clears cursors but I've remapped <C-L> to run tests, so fold it into <ESC> instead)
map('n', '<ESC>', function()
  vim.cmd('nohlsearch')
  vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_create_namespace('nvim.multicursor'), 0, -1)
end, { silent = true })

-- multicursor
-- (built into neovim, neovim/neovim#41587)
-- edit as normal; i/a/c/A/I/$/0 apply at every cursor. Clear the extra cursors with <ESC>.
-- See :help multicursor for Q, ]C/[C, etc.
--
-- Incremental "add next match" (like vim-visual-multi's <C-n>): each press adds
-- one more cursor on the next occurrence, rather than grabbing every match at
-- once. The primary cursor rides the newest match; older matches are extra
-- cursors. (mc_dedupe sweeps the cursor coinciding with the primary, so the
-- overlap never double-edits.)
local mc_ns = vim.api.nvim_create_namespace('nvim.multicursor')
local function mc_active()
  return #vim.api.nvim_buf_get_extmarks(0, mc_ns, 0, -1, { limit = 1 }) > 0
end

-- Seed a new session on `pattern` with a cursor at `col0` (0-indexed) on the
-- current line, or advance an existing session by one match.
local function mc_step(pattern, col0)
  if mc_active() then
    vim.cmd('normal! nQ') -- next match of the last pattern, add a cursor there
  else
    vim.fn.setreg('/', pattern)
    vim.opt.hlsearch = true
    vim.api.nvim_win_set_cursor(0, { vim.fn.line('.'), col0 })
    vim.cmd('normal! Q') -- pin the first cursor
  end
end

-- Normal <C-n>: start/extend from the whole word under the cursor.
map('n', '<C-n>', function()
  local word = vim.fn.expand('<cword>')
  if not mc_active() and word == '' then
    return
  end
  local pat = [[\V\<]] .. vim.fn.escape(word, [[\]]) .. [[\>]]
  -- start of the word under the cursor (0-indexed col)
  local s = vim.fn.searchpos(pat, 'bcnW')
  mc_step(pat, s[1] ~= 0 and s[2] - 1 or vim.fn.col('.') - 1)
end, { desc = 'Multicursor: add cursor on next match of <cword>' })

-- Visual <C-n>: start/extend from the selection, so you can match a partial
-- word / arbitrary substring (plain Q on a selection is the built-in per-line
-- variant instead).
map('x', '<C-n>', function()
  local vpos, cpos = vim.fn.getpos('v'), vim.fn.getpos('.')
  local region = vim.fn.getregion(vpos, cpos, { type = vim.fn.mode() })
  vim.cmd('normal! \27') -- leave Visual mode
  local sel = table.concat(region, '\n')
  if sel == '' then
    return
  end
  -- Literal (very-nomagic) match of the exact selection, no word boundaries.
  local pat = ('\\V' .. vim.fn.escape(sel, '\\')):gsub('\n', '\\n')
  -- selection start = earlier of the two ends (row then col)
  local s = (vpos[2] < cpos[2] or (vpos[2] == cpos[2] and vpos[3] <= cpos[3])) and vpos or cpos
  if not mc_active() then
    vim.api.nvim_win_set_cursor(0, { s[2], s[3] - 1 })
  end
  mc_step(pat, s[3] - 1)
end, { desc = 'Multicursor: add cursor on next match of the selection' })
