require('onedark').setup()

local c = require('onedark.colors')

-- disable dark sidebar
vim.cmd('highlight NvimTreeNormal guibg=' .. c.bg0)
vim.cmd('highlight NvimTreeVertSplit guibg=' .. c.bg0)
vim.cmd('highlight NvimTreeEndOfBuffer guibg=' .. c.bg0)

-- hide status bar in the tree
vim.cmd('highlight NvimTreeStatusline guibg=' .. c.bg0 .. ' guifg=' .. c.bg0)
vim.cmd('highlight NvimTreeStatuslineNc guibg=' .. c.bg0)

-- set pmenu highlight to green
vim.cmd('highlight PmenuSel guibg=' .. c.green)
