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
map('n', '<C-\\>', ':vsplit<CR>') -- in my head this is C-| (pipe)
map('n', '<C-_>', ':split<CR>')

-- resize vertical splits
map('n', '=', ':exe "vertical resize " . (winwidth(0) * 9/8)<CR>') -- in my head this is `+`
map('n', '-', ':exe "vertical resize " . (winwidth(0) * 7/8)<CR>')

-- tab for tabs
map('n', '<Tab>', ':tabnext<CR>')
map('n', '<S-Tab>', ':tabprev<CR>')

-- gimme ctrl s
map('n', '<C-s>', ':call Save()<CR>')
map('i', '<C-s>', '<ESC>:call Save()<CR>i')

-- tmux navigation
vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_save_on_switch = 2

map('n', '<C-Left>',  ':TmuxNavigateLeft<CR>',  {silent = true})
map('n', '<C-Down>',  ':TmuxNavigateDown<CR>',  {silent = true})
map('n', '<C-Up>',    ':TmuxNavigateUp<CR>',    {silent = true})
map('n', '<C-Right>', ':TmuxNavigateRight<CR>', {silent = true})

map('n', '<C-z>', ':NeoZoomToggle<CR>', {silent = true})

-- vim-test / vimux
vim.g['test#strategy'] = 'vimux' -- make test commands execute using vimux
vim.g['VimuxUseNearest'] = 0 -- don't use an exisiting pane
vim.g['VimuxHeight'] = '25'

map('n', '<C-t>', ':w<CR> :TestFile<CR>')
map('n', '<C-l>', ':w<CR> :TestNearest<CR>')

-- nvim-tree
map('n', '<C-b>', ':NvimTreeFindFileToggle<CR>')

-- fzf
map('n', '<C-p>', ':Files<CR>')
map('n', '<C-h>', ':History<CR>')
map('n', '<C-f>', ':RG <C-R><C-W><CR>', {silent = true})
