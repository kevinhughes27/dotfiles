" toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" close NERDTree if it is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" for mouse click in
let g:NERDTreeMouseMode=3

" show hidden files
let g:NERDTreeShowHidden=1

" hide the ? for help text
let NERDTreeMinimalUI = 1

" don't show the up a directory helper
let NERDTreeDirArrows = 1
