return {
  {
    'mrjones2014/smart-splits.nvim',
    config = function() require('smart-splits').setup({}) end,
    lazy = false,
    keys = {
      { '<C-Left>',  ':SmartCursorMoveLeft<CR>',  silent = true },
      { '<C-Down>',  ':SmartCursorMoveDown<CR>',  silent = true },
      { '<C-Up>',    ':SmartCursorMoveUp<CR>',    silent = true },
      { '<C-Right>', ':SmartCursorMoveRight<CR>', silent = true },
      { '<A-Left>',  ':SmartResizeLeft  5<CR>',   silent = true },
      { '<A-Right>', ':SmartResizeRight 5<CR>',   silent = true },
      { '<A-Up>',    ':SmartResizeUp    5<CR>',   silent = true },
      { '<A-Down>',  ':SmartResizeDown  5<CR>',   silent = true },
    }
  },
}
