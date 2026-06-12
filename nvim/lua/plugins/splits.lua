-- smart-splits: move/resize seamlessly across nvim splits (and tmux panes).
-- No setup() needed; just the keymaps that drive its commands.
vim.keymap.set('n', '<C-Left>',  ':SmartCursorMoveLeft<CR>',  { silent = true })
vim.keymap.set('n', '<C-Down>',  ':SmartCursorMoveDown<CR>',  { silent = true })
vim.keymap.set('n', '<C-Up>',    ':SmartCursorMoveUp<CR>',    { silent = true })
vim.keymap.set('n', '<C-Right>', ':SmartCursorMoveRight<CR>', { silent = true })
vim.keymap.set('n', '<A-Left>',  ':SmartResizeLeft  5<CR>',   { silent = true })
vim.keymap.set('n', '<A-Right>', ':SmartResizeRight 5<CR>',   { silent = true })
vim.keymap.set('n', '<A-Up>',    ':SmartResizeUp    5<CR>',   { silent = true })
vim.keymap.set('n', '<A-Down>',  ':SmartResizeDown  5<CR>',   { silent = true })
