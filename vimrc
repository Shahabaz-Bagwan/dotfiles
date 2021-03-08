set nu rnu " relative line numbers
set exrc " use vim config in vi
set secure " doesn't allow other users to write in vimrc
set incsearch " incremental serach
set hlsearch " no highlights in serach
set ignorecase "ignores case while searching
set tabstop=2 " set tab to 2 space width
set shiftwidth=2 " convert tabs to 2 spaces
set noswapfile " no need to create swap file it may slow the computer
set smarttab " sets tabs according to tabstop
set softtabstop=0 expandtab " similar to tabstop but in local buffer
set ai " auto indent when typing
set nofoldenable " no fold when opening files
set fdm=syntax " fold according to syntax
set si " substitute command for bracket sub
"set smartcase " pattern for search
set nocp " no compatible 
set wildmode=longest,list,full

" shows white spacing
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

syntax enable " enables syntax highlighting
filetype plugin on
colorscheme desert
set title
set bg=light
"set mouse=a " insted use SHIFT+ctrl+C and shift+ctrl+V for copy and paste
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

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
Plug 'djoshea/vim-autoread' "reloads current open file if there are changes
Plug 'preservim/nerdcommenter' " add comments in file
Plug 'terryma/vim-multiple-cursors' " multiple cursor
Plug 'junegunn/fzf.vim' " fuzzy search
Plug 'tpope/vim-surround' " surround with braces or punctuation
Plug 'scrooloose/nerdtree' " tree explorer
Plug 'bling/vim-airline' " vim-statusbar theme
Plug 'valloric/youcompleteme' " auto-complete in vim
Plug 'ap/vim-css-color' " shows color of css codes
Plug 'editorconfig/editorconfig-vim' " uses the formatter from project
" List ends here. Plugins become visible to Vim after this call.

call plug#end()
let mapleader=","
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"

" Kye bindings
nmap <F6> :NERDTreeToggle<CR>
nmap <F4> :TagbarToggle<CR>
" changes all occurance of a word under cursor
":%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <F8> :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
" toggles list
nnoremap <F3> :set list!<CR>
" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" air-line
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" autocmd for special files
autocmd BufWritePost ~/git/dwmblocks/config.h !cd ~/git/dwmblocks/; sudo make install; killall -q dwmblocks; setsid dwmblocks &

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif
