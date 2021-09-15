set nu rnu " relative line numbers
set exrc " use vim config in vi
set secure " doesn't allow other users to write in vimrc
set incsearch " incremental serach
set hidden " keep a buffer open in bg 
set scrolloff=8 " start scrolling before end of page
set nohlsearch " no highlights in serach
set ignorecase "ignores case while searching
set tabstop=2 " set tab to 2 space width
set shiftwidth=2 " convert tabs to 2 spaces
set backspace=indent,eol,nostop
set noswapfile " no need to create swap file it may slow the computer
set smarttab " sets tabs according to tabstop
set softtabstop=0 " similar to tabstop but in local buffer
set expandtab  " convert tabs to space
set ai " auto indent when typing
set nofoldenable " no fold when opening files
set fdm=syntax " fold according to syntax
set si " substitute command for bracket sub
set nocp " no compatible 
set wildmode=longest,list,full
set spell
set spelllang=en_us,de_de
set path+=** " Provides tab-completion
set complete=.,w,u,t,b,kspell

" shows white spacing
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

syntax enable " enables syntax highlighting
filetype plugin  indent on
colorscheme desert
set title
set bg=dark
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
Plug 'Raimondi/delimitMate'
Plug 'ycm-core/YouCompleteMe'
Plug 'djoshea/vim-autoread' "reloads current open file if there are changes
Plug 'preservim/nerdcommenter' " add comments in file
Plug 'bling/vim-airline' " vim-statusbar theme
Plug 'ap/vim-css-color' " shows color of css codes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " fuzzy search
Plug 'sharkdp/bat' " requirement for fzf
Plug 'BurntSushi/ripgrep' " requirement for fzf
Plug 'ggreer/the_silver_searcher' " requirement for fzf
Plug 'dandavison/delta' " requirement for fzf
Plug 'Chiel92/vim-autoformat'
Plug 'ilyachur/cmake4vim'

" List ends here. Plugins become visible to Vim after this call.

call plug#end()

let mapleader=","
let g:cmake_build_dir="build"
let g:cmake_compile_commands="1"
let g:cmake_compile_commands_link="build/compile_commands.json"
let g:cmake_usr_args="--parallel"
let g:netrw_banner=0
let g:netrw_liststyle=3

" create tags
command! MakeTags !ctags -R . 

" once the tags are generated you can jump the tags with
" ^] to jump to tag under cursor
"  g^] for ambiguous tags
" ^t jump back the tag stack
" or complete the text with ^x^n just this file,
" ^x^f Filename,
" ^x^] for tags only,
" ^n for anything

" Key bindings
let g:NetrwIsOpen=0
let g:netrw_winsize=20

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

noremap <silent> <F6> :call ToggleNetrw()<CR>

" changes all occurrence of a word under cursor
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

" Shortcut split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map ; :

" air-line
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

" autocmd for special files
autocmd BufWritePost ~/repos/dwmblocks/config.h !cd ~/repos/dwmblocks/;make clean; make; killall -q dwmblocks; setsid dwmblocks &

au BufWritePost *.tex silent! !pdflatex % >/dev/null 2>&1; redraw!

au BufWritePre *.py :Autoformat

function! Formatonsave()
  let l:formatdiff = 1
  pyf ~/llvm/tools/clang/tools/clang-format/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab

map <leader>vimrc :tabe ~/.vimrc<cr>
autocmd BufWritePost ~/.vimrc source $MYVIMRC 

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif
