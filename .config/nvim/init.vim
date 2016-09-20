" dein package manager
set runtimepath+=/Users/db/clones/dein.vim/repos/github.com/Shougo/dein.vim
call dein#begin('/Users/db/clones/dein/vim')
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('tpope/vim-fugitive')

call dein#end()

filetype plugin indent on
syntax enable
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ignorecase
set number
set textwidth=79
set colorcolumn=+5
