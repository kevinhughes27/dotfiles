" standalone vimrc
" curl -fLo ~/.vimrc https://raw.githubusercontent.com/kevinhughes27/dotfiles/master/vimrc
"
set nocompatible

" syntax
syntax on
filetype plugin indent on

" colors
colorscheme delek
set background=dark

" settings
set encoding=UTF-8
set mouse=a          " allow mouse
set wildmenu         " show tab completions in status bar
set ruler            " enable ruler
set number           " show line numbers
set showmatch        " highlight matching [{()}]
set tabstop=2        " number of visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
set autoindent       " autoindent
set expandtab        " tabs are spaces
set nowrap           " do not wrap text at `textwidth`
set ignorecase       " ignore case in search
set smartcase        " case-sensitive only with capital letters
set noswapfile       " no more swapfiles
set backspace=2      " make backspace work like most other programs
set updatetime=100

" search as you type, highlight results
set incsearch
set showmatch
set hlsearch

" copy into clipboard by default
let g:os = substitute(system('uname'), '\n', '', '')
if g:os == 'Darwin'
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" strip trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" save cursor position in a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" status line
highlight Statusline ctermfg=Black ctermbg=Green
let g:currentmode={
  \ 'n'  : 'NORMAL ',
  \ 'v'  : 'VISUAL ',
  \ 'i'  : 'INSERT ',
  \ 'c'  : 'COMMAND ',
  \}
set statusline=
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=\ %f " filename
set statusline+=\ %m " modified
set statusline+=%=   " divider
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %p%%
set statusline+=\ %l:%c
set laststatus=2

" sidebar file tree
let g:netrw_banner = 0
let g:netrw_liststyle = 3    " tree mode
let g:netrw_browse_split = 4 " open in previous window
let g:netrw_altv = 1
let g:netrw_winsize = 25

function! ToggleNetrw()
    let i = bufnr('$')
    let wasOpen = 0
    while (i >= 1)
        if (getbufvar(i, '&filetype') == 'netrw')
            silent exe 'bwipeout ' . i
            let wasOpen = 1
        endif
        let i-=1
    endwhile
    if !wasOpen
        silent Lexplore
    endif
endfunction

map <C-b> :call ToggleNetrw() <CR>

map <C-s> :write <CR>

" tmux navigation
if !empty($TMUX)
  " fix arrow keys sent from tmux
  " https://stackoverflow.com/questions/15445481/mapping-arrow-keys-when-running-tmux
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"

  " https://gist.github.com/mislav/5189704
  function! TmuxMove(direction)
    let wnr = winnr()
    silent! execute 'wincmd ' . a:direction
    " if the winnr is still the same after we moved, it is the last pane
    if wnr == winnr()
      call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
    end
  endfunction

  nnoremap <silent> <C-Left>  :call TmuxMove('h')<cr>
  nnoremap <silent> <C-Down>  :call TmuxMove('j')<cr>
  nnoremap <silent> <C-Up>    :call TmuxMove('k')<cr>
  nnoremap <silent> <C-Right> :call TmuxMove('l')<cr>
endif
