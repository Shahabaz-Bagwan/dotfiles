set nu rnu
set incsearch
set nohlsearch
set tabstop=2
set shiftwidth=2
"set expandtab
set smarttab
set softtabstop=2
set ai
set si
set smartcase
set ignorecase
set cursorline
set fdm=syntax
syntax enable

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has("gui_running")
    set guifont=Inconsolata\ Nerd\ Font\ Mono\ 12
    colorscheme evening
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'valloric/youcompleteme'
Plug 'ap/vim-css-color'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let mapleader = " "

" Kye bindings
" air-line
let g:airline_powerline_fonts = 1
