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

-- set url highlight color
vim.g.highlighturl_guifg = c.blue

-- tree
vim.cmd('highlight! NvimTreeWinSeparator guifg=' .. '#3e4452')

-- cmp
vim.cmd('highlight! CmpItemAbbrMatch guifg=' .. '#569CD6')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guifg=' .. '#569CD6')

vim.cmd('highlight! CmpItemKindClass guifg=' .. c.cyan)
vim.cmd('highlight! CmpItemKindMethod guifg=' .. c.blue)
vim.cmd('highlight! CmpItemKindVariable guifg=' .. c.purple)
vim.cmd('highlight! CmpItemKindFunction guifg=' .. c.blue)
vim.cmd('highlight! CmpItemKindKeyword guifg=' .. c.red)
vim.cmd('highlight! CmpItemKindText guifg=' .. c.fg)

-- highlight on yank
vim.cmd('highlight! YankPost guifg=' .. c.black .. ' guibg=' .. c.blue)
local highlight_group = vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({higroup='YankPost', timeout=500})
  end
})

-- :call SynStack() to get the highlight under the cursor
-- https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
vim.api.nvim_exec([[
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]], true)
