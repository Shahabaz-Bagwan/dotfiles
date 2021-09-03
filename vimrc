set nu rnu " relative line numbers
set exrc " use vim config in vi
set secure " doesn't allow other users to write in vimrc
set incsearch " incremental serach
set hlsearch " no highlights in serach
set ignorecase "ignores case while searching
set tabstop=4 " set tab to 4 space width
set shiftwidth=4 " convert tabs to 4 spaces
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
"set spell spelllang=en_us

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
  set guifont=UbuntuMono\ Nerd\ Font\ Mono\ 12
  colorscheme evening
endif


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'preservim/tagbar'
Plug 'Townk/vim-autoclose'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-Syntax' " plantuml syntax highlight 
Plug 'tyru/open-browser.vim' " opens browser 
Plug 'djoshea/vim-autoread' "reloads current open file if there are changes
Plug 'preservim/nerdcommenter' " add comments in file
Plug 'terryma/vim-multiple-cursors' " multiple cursor
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " fuzzy search
Plug 'sharkdp/bat' " requirement for fzf
Plug 'BurntSushi/ripgrep' " requirement for fzf
Plug 'ggreer/the_silver_searcher' " requirement for fzf
Plug 'dandavison/delta' " requirement for fzf
Plug 'tpope/vim-surround' " surround with braces or punctuation
Plug 'scrooloose/nerdtree' " tree explorer
Plug 'vim-latex/vim-latex' " latex tools for vim
Plug 'bling/vim-airline' " vim-statusbar theme
Plug 'valloric/youcompleteme' " auto-complete in vim
Plug 'ap/vim-css-color' " shows color of css codes
Plug 'editorconfig/editorconfig-vim' " uses the formatter from project
Plug 'Chiel92/vim-autoformat'
Plug 'ilyachur/cmake4vim'

" List ends here. Plugins become visible to Vim after this call.

call plug#end()

let mapleader=","
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
let g:cmake_build_dir="build"
let g:cmake_compile_commands="1"
let g:cmake_compile_commands_link="build/compile_commands.json"
let g:cmake_usr_args="--parallel"

" Kye bindings
nmap <F6> :NERDTreeToggle<CR>
nmap <F4> :TagbarToggle<CR>

" changes all occurance of a word under cursor
":%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <F8> :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" toggles list
nnoremap <F3> :set list!<CR>

" run python file
nnoremap <F5> :!python3 %<CR>

" runs code formatter plug-in 
noremap <F4> :Autoformat<CR>

" run clangFormat on slected text
map <C-K> :pyf </usr/share/clang/clang-format-10/clang-format.py<cr> 
imap <C-K> <c-o> :pyf </usr/share/clang/clang-format-10/clang-format.py<cr> 

" NerdTree
"let g:netrw_browsex_viewer=firefox

" preview plantUML
nnoremap <F1> :PlantumlOpen<CR>
nmap <silent> <Leader><F1> :PlantumlStart<CR> 


" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" air-line
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" autocmd for special files
autocmd BufWritePost ~/repos/dwmblocks/config.h !cd ~/repos/dwmblocks/;make clean; make; killall -q dwmblocks; setsid dwmblocks &

au BufWritePost *.tex silent! !pdflatex % >/dev/null 2>&1; redraw!

"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0

au BufWritePre *.py :Autoformat

function! Formatonsave()
  let l:formatdiff = 1
  pyf ~/llvm/tools/clang/tools/clang-format/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

map <leader>vimrc :tabe ~/.vimrc<cr>
autocmd BufWritePost ~/.vimrc source $MYVIMRC 

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif
