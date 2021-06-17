# .vimrc

~/.vimrc

### Shortcuts
    jj : Escape shortcut
    
```
inoremap jj <Esc>
filetype plugin indent on          " filetype detection and settings
silent! runtime macros/matchit.vim 
set nocompatible                   
set backspace=indent,eol,start     " let the backspace key work "normally"
set hidden                         " hide unsaved buffers
set incsearch                      " incremental search rules
set laststatus=2                   
set ruler                          " shows line number in the status line
set switchbuf=useopen,usetab       " better behavior for the quickfix window and :sb
set tags=./tags;/,tags;/           " search tags files efficiently
set wildmenu                       " better command line completion, shows a list of matches
nnoremap gb :buffers<CR>:sb<Space> " quick buffer navigation
set relativenumber
set number
call plug#begin()
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()
set clipboard=unnamedplus
```
