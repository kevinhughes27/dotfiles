" Plugins
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/vim-plug')
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'chengzeyi/fzf-preview.vim'
call plug#end()

set background=dark

set mouse=a          " allow mouse  
set number           " show line numbers
set showmatch        " highlight matching [{()}]
set tabstop=2        " number of visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
set expandtab        " tabs are spaces

" <C-w> then arrows to switch between panes. 'w' again cycles

" Gemfile syntax
autocmd BufNewFile,BufRead Gemfile set filetype=ruby

" NERDTree
source ~/dotfiles/vim/plugin-conf/nerdtree

" GitGutter
highlight! link SignColumn LineNr

" fzf
source ~/dotfiles/vim/plugin-conf/fzf
