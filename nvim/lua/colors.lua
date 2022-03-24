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

-- markdown strikethrough
vim.cmd('highlight! MarkdownStrikethrough gui=strikethrough guifg=' .. c.grey)
vim.cmd('highlight! Conceal gui=NONE guifg=NONE')

vim.api.nvim_exec([[
set conceallevel=3
call matchadd('MarkdownStrikethrough', '\~\~\zs.\+\ze\~\~')
call matchadd('MarkdownStrikethrough', '\[x\].\+')
call matchadd('Conceal',  '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
call matchadd('Conceal',  '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})
]], true)
