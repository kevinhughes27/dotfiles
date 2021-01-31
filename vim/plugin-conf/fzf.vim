" start fzf from the top. opens in a terminal buffer
let g:fzf_layout = { 'up': '100%' }

" configure the preview for default commands
" needs to be passed in to anything I override
let g:fzf_preview_window = ['down:60%']

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

" ctrl p fuzzy open all files
nnoremap <C-p> :Files<CR>

" ctrl h fuzzy open recent files
nnoremap <C-h> :History<CR>

command! -bang -nargs=* Rg
   \ call fzf#vim#grep("rg --line-number --no-heading --smart-case -- ".shellescape(<q-args>),
   \ 1, fzf#vim#with_preview({}, 'down:80%:noborder:+{2}-/6'), <bang>0)

command! -bang -nargs=? -complete=dir Files
   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({}, 'down:70%'), <bang>0)
