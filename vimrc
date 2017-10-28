" Reset some otions when resourcing .vimrc
set nocompatible
filetype off

" add Vundle to to the runtimepath
set rtp+=~/.vim/bundle/Vundle.vim

" Use vundle to manage/load the plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'SirVer/ultisnips.git'
Plugin 'honza/vim-snippets'
Plugin 'python-mode/python-mode.git'
call vundle#end()

let g:pymode_python = 'python3'
let g:pymode_options_colorcolumn = 0

" Ultisnips Settings
let g:UltiSnipsExpandTrigger="<c-c>"
let g:UltiSnipsListSnippets="<c-s-tab>"


" CtrlP settings
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" netrw file browser settings
let g:netrw_banner=0		    " Hide the directory banner
let g:netrw_liststyle=3		    " 0=thin; 1=long; 2=wide; 3=tree


" Lightline settings
set noshowmode      " Hide vims info and use lightline instead

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction


set shell=/bin/bash
set backspace=indent,eol,start  " Make bs work across line breaks etc
set hidden          " opening new file hides current instead of closing
set nowrap          " switch off line wrapping
set tabstop=4       " Set tabs to 4 characaters wide
set shiftwidth=4    " Set indentation width to match tab
set expandtab       " Use spaces instead of actual hard tabs
set softtabstop=4   " Set the soft tab to match the hard tab width
set smarttab        " space according to shiftwidth
set autoindent      " Enable basic auto indentation
set copyindent      " Preserve manual indentation
set number          " Show line number gutter
set relativenumber  " Make line numbers relative
set shiftround      " Tabs space to next mutiple of shiftwidth
set showmatch       " Highlight matching brackets, ie ( { [
set ignorecase      " Make searches case insensitive
set smartcase       " Make case sensitive when search includes uppercase
set hlsearch        " Highlight search matches``
set incsearch       " Search as you type
set history=1000    " command line history
set undolevels=1000 " Undo edits
set wildcharm=<Tab>	" Needed to open the wildmenu from shortcuts
set wildmenu        " Tab completion for command mode
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set title           " Set the window title
set ruler           " Show the cursor position
set novisualbell    " No flashing windows
set noerrorbells    " Don't disturb me!
set lazyredraw      " Redraw only when needed
set laststatus=2    " Always display the status line
set colorcolumn=0
" set cursorline      " Highlight the current line
set confirm         " Don't fail commands on unsaved files
set encoding=utf-8  " Vim recommended setting
set clipboard=unnamed   " Use system clipboard
set undodir=~/.vim/undo//       " Keep undo away from working files/dirs
set backupdir=~/.vim/backup//   " Keep backups away from working files
set directory=~/.vim/swp//      " Keep swp file away from working files
set swapfile backup undofile    " Set persistent undo etc

filetype plugin indent on       " Use default filetype settings
syntax on                       " Switch on syntax highlighting
set background=dark             " Hint to colorscheme a dark background is in use
" colorscheme gruvbox             " Set the color scheme
" hi Normal ctermbg=none        " clear any scheme bg colors to show terminal bg
colorscheme materialtheme

" Map Ctrl+[hjkl] to navigate windows vim style
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Map Ctrl+[arrow] to navigate windows splits
nnoremap <silent> <C-Left> <C-w>h
nnoremap <silent> <C-Down> <C-w>j
nnoremap <silent> <C-Up> <C-w>k
nnoremap <silent> <C-Right> <C-w>l

" Page up/down will scroll half-page and center current line on the screen
nnoremap <silent> <PageUp> <C-U>zz
vnoremap <silent> <PageUp> <C-U>zz
inoremap <silent> <PageUp> <C-O><C-U><C-O>zz

nnoremap <silent> <PageDown> <C-D>zz
vnoremap <silent> <PageDown> <C-D>zz
inoremap <silent> <PageDown> <C-O><C-D><C-O>zz

" Increase/descrease window split size
if bufwinnr(1)
    map + <C-W>+
    map - <C-W>-
endif

" F2 to toggle paste mode
nnoremap <silent> <F2> :set paste!<CR>

" F3 to remove all trailing whitespace
nnoremap <silent> <F3> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

let mapleader=","

" Open netrw filebrowser in current window, with current file selected
nmap <leader>e :e .<CR>

" Quick save the current file
nmap <leader>w :w<CR>

" Reindent the file, keeping the cursor on original line
nmap <leader>i mzgg=G`z

" Insert empty line below
nmap <silent> <leader><CR> o<ESC>

" Clear search highlights
nmap <silent> <leader><space> :noh<CR>

" Rotate window splits
nmap <leader>r <C-w>r

" Close buffer without affecting splits
nmap <leader>d :bprevious<CR>:bdelete #<CR>

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
