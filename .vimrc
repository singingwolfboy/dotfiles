set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
" Bundle 'kevinw/pyflakes-vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'javascript.vim'

filetype plugin indent on
" let mapleader = ","

set background=dark

" set modelines=0
syntax on

set expandtab
function SetWidth4()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endfunction
function SetWidth2()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction
call SetWidth4()
au BufNewFile,BufRead *.coffee call SetWidth2()

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set cursorline
set ruler
set ttyfast
set backspace=indent,eol,start
set laststatus=2
" set relativenumber
set number

" set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set nobackup
set noswapfile

" nnoremap / /\v
" vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <tab> %
vnoremap <tab> %
set grepprg=ack
set grepformat=%f:%l:%m

set wildmode=longest,list,full
set wildmenu

set wrap
set formatoptions=qrn1
set textwidth=79
if exists('&colorcolumn')
  set colorcolumn=+5
end

" use system pasteboard
set clipboard=unnamed

nnoremap j gj
nnoremap k gk

" F1 is help, these lines change it to ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

if filereadable($VIMRUNTIME . "/macros/matchit.vim")
 source $VIMRUNTIME/macros/matchit.vim
endif

" nnoremap <leader>a :Ack
nnoremap <leader>` :NERDTreeToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>

" set the names of flags
let tlist_php_settings = 'php;c:class;f:function;d:constant'
" close all folds except for current file
let Tlist_File_Fold_Auto_Close = 1
" make tlist pane active when opened
let Tlist_GainFocus_On_ToggleOpen = 1
" width of window
let Tlist_WinWidth = 40
" close tlist when a selection is made
let Tlist_Close_On_Select = 1

let g:yankring_history_dir = '$HOME/.vim'

" grab sudo privs to write on w!!
cmap w!! w !sudo tee % > /dev/null

map gf <C-W>f

au BufNewFile,BufRead /opt/local/apache2/conf/vservers/*.conf setf apache

if filereadable("~/.vim/bundle/python/vimrc")
    source ~/.vim/bundle/python/vimrc
endif

" switch into and out of pastemode on command-V
imap <Leader>v  <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>

" uncomment to disable pyflakes-vim
" let b:did_pyflakes_plugin = 1

" let g:pep8_ftplugin_loaded = 1
" let g:pep8_ignore_autocmd = 1
let g:pep8_ignore="E251,E3,E5,W391"
" let g:pep8_ignore="E251,E5,W391"
"
let g:Powerline_symbols="fancy"

let g:syntastic_check_on_open=1

setlocal omnifunc=syntaxcomplete#Complete
