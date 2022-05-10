" Markdown

" enable linewrap
setlocal wrap linebreak nolist

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

" link text
highlight! markdownLinkText gui=underline guifg=#5ab0f6
syn region markdownLinkText
  \ matchgroup=markdownLinkTextDelimiter
  \ start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@="
  \ end="\]\%( \=[[(]\)\@="
  \ nextgroup=markdownLink,markdownId skipwhite
  \ contains=@markdownInline,markdownLineStart
  \ concealends

" check and uncheck checkboxes
" https://www.reddit.com/r/vim/comments/c2h28r/a_small_markdown_mapping_for_checkboxes/
function Check()
  let l:line=getline('.')
  let l:curs=winsaveview()

  if l:line=~?'\s*-\s*\[\s*\].*'
      s/\[\s*\]/[x]/
  elseif l:line=~?'\s*-\s*\[x\].*'
      s/\[x\]/[ ]/
  endif

  call winrestview(l:curs)
endfunction

nnoremap <silent> <CR> :call Check()<CR>
nnoremap <silent> <space> :call Check()<CR>
