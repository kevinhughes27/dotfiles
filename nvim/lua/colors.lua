-- Colors

require('onedark').setup({
  transparent = true
})

require('onedark').load()

local c = require('onedark.colors')

-- set pmenu highlight to green
vim.cmd('highlight PmenuSel guibg=' .. c.green)

-- set selected tab highlight to blue
vim.cmd('highlight TabLineSel guibg=' .. c.blue)

-- cmp
vim.cmd('highlight! CmpItemAbbrMatch guifg=' .. '#569CD6')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guifg=' .. '#569CD6')

vim.cmd('highlight! CmpItemKindClass guifg=' .. c.cyan)
vim.cmd('highlight! CmpItemKindMethod guifg=' .. c.blue)
vim.cmd('highlight! CmpItemKindVariable guifg=' .. c.purple)
vim.cmd('highlight! CmpItemKindFunction guifg=' .. c.blue)
vim.cmd('highlight! CmpItemKindKeyword guifg=' .. c.red)
vim.cmd('highlight! CmpItemKindText guifg=' .. c.fg)
