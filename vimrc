" standalone vimrc
" curl -fLo ~/.vimrc https://raw.githubusercontent.com/kevinhughes27/dotfiles/master/vimrc
"
set nocompatible

" syntax
syntax on
filetype plugin indent on

" colors
" https://github.com/joshdick/onedark.vim/blob/main/autoload/onedark.vim
let s:red = "1"
let s:dark_red = "9"
let s:green = "2"
let s:yellow = "3"
let s:dark_yellow = "11"
let s:blue = "4"
let s:purple = "5"
let s:cyan = "6"
let s:white = "15"
let s:black = "0"
let s:grey = "7"
let s:dark_grey = "8"

set background=dark

" https://github.com/joshdick/onedark.vim/blob/main/colors/onedark.vim#L76
function s:h(group, style)
  execute "highlight" a:group
    \ "ctermfg=" (has_key(a:style, "fg") ? a:style.fg : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg") ? a:style.bg : "NONE")
    \ "cterm="   (has_key(a:style, "cterm")   ? a:style.cterm : "NONE")
endfunction

" syntax colors
" https://github.com/joshdick/onedark.vim/blob/main/colors/onedark.vim#L193
call s:h("Comment", { "fg": s:grey, "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:dark_yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:dark_yellow }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:dark_yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:purple }) " any statement
call s:h("Conditional", { "fg": s:purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:purple }) " case, default, etc.
call s:h("Operator", { "fg": s:purple }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:red }) " any other keyword
call s:h("Exception", { "fg": s:purple }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:purple }) " preprocessor #define
call s:h("Macro", { "fg": s:purple }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", { "fg": s:dark_yellow }) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)

" vim UI colors
" https://github.com/joshdick/onedark.vim/blob/main/colors/onedark.vim#L233
call s:h("LineNR", { "fg": s:dark_grey })
call s:h("StatusLine", { "fg": s:black, "bg": s:green })
call s:h("StatusLineNC", { "fg": s:black })
call s:h("TabLine", { "fg": s:grey })
call s:h("TabLineFill", {})
call s:h("Visual", { "bg": s:dark_grey })
call s:h("VertSplit", { "fg": s:grey })
call s:h("MatchParen", { "fg": s:blue, "cterm": "underline" })
call s:h("Normal", { "bg": "NONE", "fg": "NONE" })
call s:h("Pmenu", { "fg": s:white, "bg": s:grey })
call s:h("PmenuSel", { "fg": s:black, "bg": s:green })
call s:h("IncSearch", { "fg": s:yellow, "bg": s:grey })
call s:h("Search", { "fg": s:black, "bg": s:yellow })
call s:h("ModeMsg", {})

" settings
set encoding=UTF-8
set mouse=a          " allow mouse
set wildmenu         " show tab completions in status bar
set ruler            " enable ruler
set number           " show line numbers
set showmatch        " highlight matching [{()}]
set tabstop=2        " number of visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
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
