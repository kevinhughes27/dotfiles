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
