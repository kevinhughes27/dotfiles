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

set number               " show line numbers
set showmatch            " highlight matching [{()}]
set tabstop=2            " number of visual spaces per TAB
set softtabstop=4        " number of spaces in tab when editing
set expandtab            " tabs are spaces

" Gemfile syntax
autocmd BufNewFile,BufRead Gemfile set filetype=ruby

" open NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree " open nerdtree by default

" C-WW to switch between panes

" for mouse click in nerdtree
set mouse=a
let g:NERDTreeMouseMode=3 

" show hidden files
let g:NERDTreeShowHidden=1

" GitGutter
highlight! link SignColumn LineNr

" fzf
let g:fzf_layout = { 'up': '50%' }
let g:fzf_preview_window = ['down:60%', 'ctrl-/']
map <C-p> :FZF<CR>
