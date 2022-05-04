-- Mappings

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jk', '<ESC>') -- https://danielmiessler.com/study/vim/
map('n', '<ESC>', ':noh|set norelativenumber!<CR>') -- clear highlight and toggle relative numbers

-- dont lose selection when shifting sideways
-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
map('x', '<', '<gv')
map('x', '>', '>gv')

-- new splits
map('n', '<A-\\>', ':vsplit<CR>') -- in my head this is C-| (pipe)
map('n', '<A-->', ':split<CR>')

-- resize splits
map('n', '<A-Left>',  ':SmartResizeLeft  5<CR>')
map('n', '<A-Right>', ':SmartResizeRight 5<CR>')
map('n', '<A-Up>',    ':SmartResizeUp    5<CR>')
map('n', '<A-Down>',  ':SmartResizeDown  5<CR>')

-- tab for tabs
map('n', '<Tab>', ':tabnext<CR>')
map('n', '<S-Tab>', ':tabprev<CR>')

-- gimme ctrl s
map('n', '<C-s>', ':Save<CR>')
map('i', '<C-s>', '<ESC>:Save<CR>i')

-- tmux navigation
map('n', '<C-Left>',  ':TmuxNavigateLeft<CR>',  {silent = true})
map('n', '<C-Down>',  ':TmuxNavigateDown<CR>',  {silent = true})
map('n', '<C-Up>',    ':TmuxNavigateUp<CR>',    {silent = true})
map('n', '<C-Right>', ':TmuxNavigateRight<CR>', {silent = true})

-- zoom
map('n', '<C-z>', ':NeoZoomToggle<CR>', {silent = true})

-- vim-test
map('n', '<C-t>', ':w<CR> :TestFile<CR>')
map('n', '<C-l>', ':w<CR> :TestNearest<CR>')

-- nvim-tree
map('n', '<C-b>', ':NvimTreeFindFileToggle<CR>')

-- fzf
map('n', '<C-p>', ':Files<CR>')
map('n', '<C-h>', ':History<CR>')
map('n', '<C-f>', ':RG <C-R><C-W><CR>', {silent = true})
