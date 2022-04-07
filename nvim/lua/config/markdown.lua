-- rendering

local c = require('onedark.colors')

vim.cmd('highlight! MarkdownStrikethrough gui=strikethrough guifg=' .. c.grey)
vim.cmd('highlight! MarkdownStar guifg=' .. c.yellow)
vim.cmd('highlight! markdownLinkText gui=underline guifg=' .. c.blue)

vim.api.nvim_exec([[
function MarkdownHighlights()
  " :help matchadd for more information
  call matchadd('MarkdownStar', '⭐')
  call matchadd('MarkdownStrikethrough', '\~\~\zs.\+\ze\~\~')
  call matchadd('MarkdownStrikethrough', '\[x\].\+')

  " strikethrough
  call matchadd('Conceal', '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
  call matchadd('Conceal', '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})

  " checkbox
  call matchadd('Conceal', '\[\ \]', 10, -1, {'conceal': ''})
  call matchadd('Conceal', '\[x\]', 10, -1, {'conceal': ''})

  " links
  syn region markdownLink
    \ matchgroup=markdownLinkDelimiter
    \ start="(" end=")" contains=markdownUrl keepend contained
    \ conceal

  syn region markdownLinkText
    \ matchgroup=markdownLinkTextDelimiter
    \ start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@="
    \ end="\]\%( \=[[(]\)\@="
    \ nextgroup=markdownLink,markdownId skipwhite
    \ contains=@markdownInline,markdownLineStart
    \ concealends
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

-- set word wrap for markdown files
vim.api.nvim_exec([[
autocmd bufreadpre *.md setlocal wrap linebreak nolist
]], true)
