set nocompatible
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
" set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set title
set ruler
set cursorline
set novisualbell
set noerrorbells
set nobackup noswapfile
set noswapfile
set undofile

filetype off

let g:pymode_rope = 0
let g:pymode_options_max_line_length = 99 
let g:pymode_folding = 0
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_on_write = 1
let g:pymode_lint_on_fly = 1

" let g:pathogen_disabled = ['python-mode']
call pathogen#infect()
call pathogen#helptags()

" autocmd filetype python set expandtab
" let python_highlight_all = 1

filetype plugin indent on
syntax on

set background=dark
colorscheme kolor2
set colorcolumn=99
" highlight ColorColumn ctermbg=0
" highlight CursorLine cterm=None ctermbg=darkGrey

let mapleader=","

" Quick save the current file
nmap <leader>w :w<CR>

" Edit your .vimrc and load the new settings into vim
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Clear search highlights
nmap <silent> <leader><CR> :noh<CR>

" Map Ctrl+arrow keys to navigate windows
nnoremap <silent> <C-Left> <C-w>h
nnoremap <silent> <C-Down> <C-w>j
nnoremap <silent> <C-Up> <C-w>k
nnoremap <silent> <C-Right> <C-w>l

" Tab navigation
" nnoremap <C-Tab>  :tabprevious<CR>
nnoremap <C-Tab>  :tabnext<CR>
nnoremap <C-t>    :tabnew<CR>

" Overwrite <F1> to toggle NerdTree
nnoremap <silent> <F1> :NERDTreeToggle<CR>

" Save and run the current python file
nnoremap <silent> <F5> :w <bar> :!clear;python %<CR>

set pastetoggle=<F3>
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
	    return 'Paste ON '
	else
	    return 'Paste OFF'
    endif
    return ''
endfunction

fun! HasMouse()
    if &mouse == ""
        return 'Mouse TRM'
    else
        return 'Mouse VIM'
    endif
endfunction

" Have the status line always visible
set laststatus=2
set statusline=\ %{HasMouse()}\ \>\ %{HasPaste()}\ \>\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" set statusline=\ %t\ %w%m%r%=[%{strlen(&ft)?&ft:'no\ ft'}]\ %l:%v\ 

" hi statusline insert/normal mode
au InsertLeave * highlight StatusLine      ctermfg=none  ctermbg=24  cterm=none
au InsertEnter * highlight StatusLine      ctermfg=0     ctermbg=10  cterm=none


" Set mouse on by default and toggle with F3
set mouse=a
noremap <silent> <F2> :call <SID>ToggleMouse()<CR>
fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        set nopaste
    else
        let s:old_mouse = &mouse
        let &mouse=""
        set paste
    endif
endfunction

"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left

noremap <F4> :call <SID>Kwbd(1)<CR>

fun! s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction
