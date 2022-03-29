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

-- markdown fancy things
vim.cmd('highlight! MarkdownStrikethrough gui=strikethrough guifg=' .. c.grey)
vim.cmd('highlight! MarkdownStar guifg=' .. c.yellow)

vim.api.nvim_exec([[
" :help matchadd for more information

function MarkdownHighlights()
  call matchadd('MarkdownStar', '⭐')
  call matchadd('MarkdownStrikethrough', '\~\~\zs.\+\ze\~\~')
  call matchadd('MarkdownStrikethrough', '\[x\].\+')

  call matchadd('Conceal', '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
  call matchadd('Conceal', '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})

  call matchadd('Conceal', '\[\ \]', 10, -1, {'conceal': ''})
  call matchadd('Conceal', '\[x\]', 10, -1, {'conceal': ''})
endfunction

function ClearMarkdownHighlights()
  call clearmatches()
endfunction

augroup mdHighlights
  autocmd!
  autocmd BufWinEnter * call ClearMarkdownHighlights()
  autocmd BufWinEnter *.md call MarkdownHighlights()
augroup END
]], true)
