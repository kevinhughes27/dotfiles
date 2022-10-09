-- Mappings
local map = vim.keymap.set

-- resize splits
map('n', '<A-Left>',  ':SmartResizeLeft  5<CR>')
map('n', '<A-Right>', ':SmartResizeRight 5<CR>')
map('n', '<A-Up>',    ':SmartResizeUp    5<CR>')
map('n', '<A-Down>',  ':SmartResizeDown  5<CR>')

-- smart tab next|prev that moved the cursor out of the tree
-- if necessary. this makes the tabline display a file instead of
-- NvimTree_ after tabbing away.
function Smart_tab(tabcmd)
  local current_buffer = vim.api.nvim_buf_get_name(0)

  if current_buffer:match('NvimTree_%d+') then
    vim.api.nvim_exec('winc l', true)
  end

  vim.api.nvim_exec(tabcmd, true)
end

-- tab for tabs
-- map('n', '<A-t>', ':tabnew<CR>')
map('n', '<Tab>', function() Smart_tab('tabnext') end)
map('n', '<S-Tab>', function() Smart_tab('tabprev') end)

-- gimme ctrl s
map('n', '<C-s>', ':Save<CR>')
map('i', '<C-s>', '<ESC>:Save<CR>')

-- tmux navigation
map('n', '<C-Left>',  ':TmuxNavigateLeft<CR>',  {silent = true})
map('n', '<C-Down>',  ':TmuxNavigateDown<CR>',  {silent = true})
map('n', '<C-Up>',    ':TmuxNavigateUp<CR>',    {silent = true})
map('n', '<C-Right>', ':TmuxNavigateRight<CR>', {silent = true})

-- zoom (opens new tab)
map('n', '<C-z>', ':tabe %<CR>', {silent = true})

-- vim-test
map('n', '<C-t>', ':w<CR> :TestFile<CR>')
map('n', '<C-l>', ':w<CR> :TestNearest<CR>')

-- nvim-tree
map('n', '<C-b>', ':NvimTreeFindFileToggle<CR>', {silent = true})

-- fzf
map('n', '<C-p>', ':Files<CR>')
map('n', '<C-h>', ':History<CR>')
map('n', '<C-f>', ':RG <C-R><C-W><CR>', {silent = true})

-- clear highlight
map('n', '<ESC>', ':noh<CR>', {silent = true})

-- toggle relative numbers
-- map('n', 'rl', ':set norelativenumber!<CR>')

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
