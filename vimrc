set nu rnu " relative line numbers
set exrc " use vim config in vi
set secure " doesn't allow other users to write in vimrc
set incsearch " incremental serach
set hlsearch " no highlights in serach
set tabstop=2 " set tab to 2 space width
set shiftwidth=2 " convert tabs to 2 spaces
set noswapfile " no need to create swap file it may slow the computer
set smarttab " sets tabs according to tabstop
set softtabstop=0 expandtab " similar to tabstop but in local buffer
set ai " auto indent when typing
set nofoldenable " no fold when opening files
set fdm=syntax " fold according to syntax
set si " substitute command for bracket sub
set smartcase " pattern for search
syntax enable " enables syntax highlighting
filetype plugin on

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
Plug 'preservim/tagbar'
Plug 'Townk/vim-autoclose'
Plug 'preserv/nerdcommenter' " add comments in file
Plug 'terryma/vim-multiple-cursors' " multiple cursor
Plug 'junegunn/fzf.vim' " fuzzy search
Plug 'tpope/vim-surround' " surround with braces or punctuation
Plug 'scrooloose/nerdtree' " tree explorer
Plug 'bling/vim-airline' " vim-statusbar theme
Plug 'valloric/youcompleteme' " auto-complete in vim
Plug 'ap/vim-css-color' " shows color of css codes
" List ends here. Plugins become visible to Vim after this call.

call plug#end()
let mapleader=","
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"

" Kye bindings
nmap <F6> :NERDTreeToggle<CR>
" air-line
let g:airline_powerline_fonts=1
