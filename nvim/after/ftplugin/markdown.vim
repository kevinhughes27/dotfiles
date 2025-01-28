" Markdown

" enable linewrap
setlocal wrap linebreak nolist

" set tabstop back to 2
" overwrite all related settings from /usr/local/share/nvim/runtime/ftplugin/markdown.vim
setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

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

nnoremap <buffer><silent> <CR> :call Check()<CR>
nnoremap <buffer><silent> <space> :call Check()<CR>
