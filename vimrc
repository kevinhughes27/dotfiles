" standalone vimrc
" curl -fLo ~/.vimrc https://raw.githubusercontent.com/kevinhughes27/dotfiles/master/vimrc
"
set nocompatible

" syntax
syntax on
filetype plugin indent on

" colors
set background=dark

" https://github.com/joshdick/onedark.vim/blob/main/autoload/onedark.vim
let s:colors = {
  \ "red": "1",
  \ "dark_red": "9",
  \ "green": "2",
  \ "yellow": "3",
  \ "dark_yellow": "11",
  \ "blue": "4",
  \ "purple": "5",
  \ "cyan": "6",
  \ "white": "15",
  \ "black": "0",
  \ "foreground": "NONE",
  \ "background": "NONE",
  \ "comment_grey": "7",
  \ "gutter_fg_grey": "8",
  \ "cursor_grey": "0",
  \ "visual_grey": "8",
  \ "menu_grey": "7",
  \ "special_grey": "7",
  \ "vertsplit": "7",
  \}

function s:h(group, style)
  execute "highlight" a:group
    \ "ctermfg=" (has_key(a:style, "ctermfg") ? a:style.ctermfg : "NONE")
    \ "ctermbg=" (has_key(a:style, "ctermbg") ? a:style.ctermbg : "NONE")
    \ "cterm="   (has_key(a:style, "cterm")   ? a:style.cterm : "NONE")
endfunction

call s:h("Normal", { "ctermbg": s:colors.background, "ctermfg": s:colors.foreground })

" syntax colors
" https://github.com/joshdick/onedark.vim/blob/main/colors/onedark.vim#L193
call s:h("Comment",    { "ctermfg": s:colors.comment_grey })
call s:h("Constant",   { "ctermfg": s:colors.cyan })
call s:h("String",     { "ctermfg": s:colors.green })
call s:h("Type",       { "ctermfg": s:colors.yellow })
call s:h("Identifier", { "ctermfg": s:colors.red })
call s:h("Special",    { "ctermfg": s:colors.blue })
call s:h("Statement",  { "ctermfg": s:colors.purple })
call s:h("Keyword",    { "ctermfg": s:colors.red })
call s:h("Directory",  { "ctermfg": s:colors.blue })

" vim UI colours
call s:h("LineNR",       { "ctermfg": s:colors.gutter_fg_grey })
call s:h("StatusLine",   { "ctermfg": s:colors.black, "ctermbg": s:colors.green })
call s:h("StatusLineNC", { "ctermfg": s:colors.black })
call s:h("TabLine",      { "ctermfg": s:colors.comment_grey })
call s:h("TabLineFill",  {})
call s:h("Visual",       { "ctermbg": s:colors.visual_grey })
call s:h("VertSplit",    { "ctermfg": s:colors.vertsplit })
call s:h("MatchParen",   { "ctermfg": s:colors.blue, "cterm": "underline" })

call s:h("Pmenu",    { "ctermfg": s:colors.white, "ctermbg": s:colors.menu_grey })
call s:h("PmenuSel", { "ctermfg": s:colors.cursor_grey, "ctermbg": s:colors.green })

call s:h("IncSearch", { "ctermfg": s:colors.yellow, "ctermbg": s:colors.comment_grey })
call s:h("Search",    { "ctermfg": s:colors.black, "ctermbg": s:colors.yellow })
call s:h("ModeMsg",   {})

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
