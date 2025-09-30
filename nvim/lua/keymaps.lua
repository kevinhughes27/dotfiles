-- Keymaps
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
