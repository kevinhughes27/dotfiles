" Markdown

" enable linewrap
setlocal wrap linebreak nolist

" set tabstop back to 2
" overwrite all related settings from /usr/local/share/nvim/runtime/ftplugin/markdown.vim
setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

" enable conceal
setlocal conceallevel=2

" strikethrough
highlight! MarkdownStrikethrough gui=strikethrough guifg=#546178

call matchadd('MarkdownStrikethrough', '\~\~\zs.\+\ze\~\~')
call matchadd('MarkdownStrikethrough', '\[x\].\+')
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

highlight! markdownLinkText gui=underline guifg=#5ab0f6

syn region markdownLinkText
  \ matchgroup=markdownLinkTextDelimiter
  \ start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@="
  \ end="\]\%( \=[[(]\)\@="
  \ nextgroup=markdownLink,markdownId skipwhite
  \ contains=@markdownInline,markdownLineStart
  \ concealends
