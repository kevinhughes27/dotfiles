set nocompatible

" Init
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'rakr/vim-one'
Plug 'wincent/terminus'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-ruby/vim-ruby'
call plug#end()

" colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme one
set background=dark

" settings
set mouse=a          " allow mouse
set number           " show line numbers
set showmatch        " highlight matching [{()}]
set tabstop=2        " number of visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
set expandtab        " tabs are spaces
set updatetime=100

" key bindings
" <C-w> then arrows to switch between panes. 'w' again cycles

" Plugin Conf
source ~/dotfiles/vim/plugin-conf/nerdtree
source ~/dotfiles/vim/plugin-conf/fzf
