let g:NERDTreeMouseMode=3 " enable mouse
let g:NERDTreeShowHidden=1 " show hidden files
let NERDTreeMinimalUI = 1 " hide the ? for help text
let NERDTreeDirArrows = 1 " don't show the up a directory helper

" close NERDTree if it is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CheckIfCurrentBufferIsFile()
  return strlen(expand('%')) > 0
endfunction

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && CheckIfCurrentBufferIsFile() && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

" Toggle NERDTree
function! ToggleTree()
  if CheckIfCurrentBufferIsFile()
    if IsNERDTreeOpen()
      NERDTreeClose
    else
      NERDTreeFind
    endif
  else
    NERDTree
  endif
endfunction

" Ctrl-n to toggle the tree on and off sync'd to the current file location
map <C-n> :call ToggleTree()<CR>
