set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim.git'
Plugin 'valloric/YouCompleteMe'
Plugin 'tpope/vim-commentary'
call vundle#end()

filetype plugin indent on
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

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
set cursorline
" set colorcolumn=85
set guioptions-=T   " Hide the toolbar on Gvim
set background=dark
set encoding=utf-8
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set swapfile backup undofile

syntax on
colorscheme gruvbox
hi Normal ctermbg=none
let c_no_curly_error=1

set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

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

" Increase/descrease window split size
if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
endif

" F1 to Toggle NerdTree
nmap <silent> <F1> :NERDTreeToggle<CR>

" F2 to toggle paste mode
nnoremap <silent> <F2> :set paste!<CR>

" F3 to remove all trailing whitespace
nnoremap <silent> <F3> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

let mapleader=","

" Quick save the current file
nmap <leader>w :w<CR>

" Insert empty line below
nmap <silent> <leader><CR> o<ESC>

" Clear search highlights
nmap <silent> <leader><space> :noh<CR>

" Close buffer without affecting splits
command! Bd bp\|bd \#
nmap <leader>d :Bd<CR>

" Easy buffer navigation
nmap <leader>n :bn<CR>
nmap <leader>p :bp<CR>

" CtrlP shorctuts
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>m :CtrlPMRU<CR>

" Load vimrc
nmap <leader>v :e ~/.vimrc<CR>

" Toggle/cycle line number modes
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
