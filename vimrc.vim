set nocompatible

" Init
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-sensible' " improved defaults
Plug 'wincent/terminus' " make vim nicer to use in tmux
Plug 'djoshea/vim-autoread' " reload files changed outside of vim

Plug 'joshdick/onedark.vim'

Plug 'airblade/vim-gitgutter'

Plug 'vim-test/vim-test'
Plug 'benmills/vimux'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-ruby/vim-ruby'
Plug 'sheerun/vim-polyglot'
call plug#end()

" colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme onedark
set background=dark

" settings
set encoding=UTF-8
set mouse=a          " allow mouse
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

" otherwise git status is super delayed
set updatetime=100

" copy into clipboard by default
let g:os = substitute(system('uname'), '\n', '', '')
if g:os == 'Darwin'
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" search as you type, highlight results
set incsearch
set showmatch
set hlsearch

" strip trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" key bindings
" <C-w> then arrows to switch between panes. 'w' again cycles

" https://danielmiessler.com/study/vim/
inoremap jk <ESC>
let mapleader = "'"

" plugin conf
source ~/dotfiles/vim/plugin-conf/nerdtree.vim
source ~/dotfiles/vim/plugin-conf/fzf.vim

" vim-test bindings
nmap <C-t> :w<CR> :TestFile<CR>
nmap <C-l> :w<CR> :TestNearest<CR>
nmap <C-s> :w<CR> :TestLast<CR>

" make test commands execute using vimux
let test#strategy = "vimux"

" vimux conf
let g:VimuxUseNearest = 0 " always open a new pane
map <C-d> :VimuxCloseRunner<CR>
