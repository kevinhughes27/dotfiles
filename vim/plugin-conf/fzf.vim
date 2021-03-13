let g:fzf_layout = { 'down': '100%' }
let g:fzf_preview_window = ['down:70%']

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
