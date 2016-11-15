set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'bling/vim-airline.git'
Plugin 'edkolev/tmuxline.vim.git'
Plugin 'vim-airline/vim-airline-themes.git'
call vundle#end()

filetype plugin indent on

" Hide the toolbar on Gvim
set guioptions-=T
set shell=/bin/bash
set hidden
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set relativenumber
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set title
set ruler
set novisualbell
set noerrorbells
set lazyredraw
set laststatus=2
" set cursorline
" set colorcolumn=85
set background=dark

set encoding=utf-8
let g:airline_powerline_fonts = 1

set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set swapfile backup undofile

syntax on
colorscheme gruvbox
hi Normal ctermbg=none
let c_no_curly_error=1

" Map Ctrl+arrow keys to navigate windows
" nnoremap <silent> <Esc>[1;5D <C-w>h
" nnoremap <silent> <Esc>[1;5B <C-w>j
" nnoremap <silent> <Esc>[1;5A <C-w>k
" nnoremap <silent> <Esc>[1;5C <C-w>l

" Map Ctrl+[hjkl] to navigate windows vim style
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Remap page keys to change default behaviour - make the same as half-page scroll
nnoremap <silent> <PageUp> <C-U><C-U>
vnoremap <silent> <PageUp> <C-U><C-U>
inoremap <silent> <PageUp> <C-\><C-O><C-U><C-\><C-O><C-U>

nnoremap <silent> <PageDown> <C-D><C-D>
vnoremap <silent> <PageDown> <C-D><C-D>
inoremap <silent> <PageDown> <C-\><C-O><C-D><C-\><C-O><C-D>

" F1 to Toggle NerdTree
nmap <silent> <F1> :NERDTreeToggle<CR>

" F2 to toggle paste mode
nnoremap <silent> <F2> :set paste!<CR>

" F3 to remove all trailing whitespace
nnoremap <silent> <F3> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

let mapleader=","

" Quick save the current file
nmap <leader>w :w<CR>

" Clear search highlights
nmap <silent> <leader><CR> :noh<CR>

" Close buffer without affecting splits
command! Bd bp\|bd \#
nmap <leader>d :Bd<CR>

" Easy buffer navigation
nmap <leader>n :bn<CR>
nmap <leader>p :bp<CR>

" CtrlP shorctuts
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>

nmap <leader>l :call CycleLineNumbers()<CR>

function! CycleLineNumbers()
  if (&number == 1 && &relativenumber == 0)
    set relativenumber
  else
    if (&relativenumber == 1 && &number == 1)
        set norelativenumber
        set nonumber
    else
        set number
        set norelativenumber
    endif
  endif
endfunc
