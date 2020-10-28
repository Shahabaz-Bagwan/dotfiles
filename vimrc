set nu rnu " relative line numbers
set exrc " use vim config in vi
set secure " doesn't allow other users to write in vimrc
set incsearch " incremental serach
set nohlsearch " no highlights in serach
set tabstop=2 " set tab to 2 space width
set shiftwidth=2 " convert tabs to 2 spaces
set noswapfile " no need to create swap file it may slow the computer
set smarttab " sets tabs according to tabstop 
set softtabstop=2 " similar to tabstop but in local buffer
set ai " auto indent when typing 
set nofoldenable " no fold when opening files
set fdm=syntax " fold according to syntax
set si " substitute command for bracket sub
set smartcase " pattern for search
set cursorline " highlights the current line
syntax enable " enables syntax highlighting

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
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-sort-motion'
"Plug 'christoomey/vim-system-copy'
Plug 'vim-scrpts/ReplaceWithRegister'
Plug 'junegunn/seoul256.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'djoshea/vim-autoread'
Plug 'bling/vim-airline'
Plug 'valloric/youcompleteme'
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
" List ends here. Plugins become visible to Vim after this call.

call plug#end()

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" Kye bindings
nmap <F6> :NERDTreeToggle<CR>
" air-line
let g:airline_powerline_fonts = 1
