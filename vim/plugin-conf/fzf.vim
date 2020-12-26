function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

" :Files
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" ctrl p fuzzy open files
nnoremap <C-p> :call FZFOpen(':Files')<CR>

" ctrl g ripgrep search
nnoremap <C-g> :Rg<Cr>

" fzf window and preview
let g:fzf_layout = { 'up': '50%' }
let g:fzf_preview_window = ['down:60%', 'ctrl-/']

let g:fzf_colors = {
 \ 'fg':      ['fg', 'Normal'],
 \ 'bg':      ['bg', 'Normal'],
 \ 'hl':      ['fg', 'Label'],
 \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
 \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
 \ 'hl+':     ['fg', 'Label'],
 \ 'info':    ['fg', 'Comment'],
 \ 'border':  ['fg', 'Ignore'],
 \ 'prompt':  ['fg', 'Function'],
 \ 'pointer': ['fg', 'Statement'],
 \ 'marker':  ['fg', 'Conditional'],
 \ 'spinner': ['fg', 'Label'],
 \ 'header':  ['fg', 'Comment'] }

