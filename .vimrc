" !silent is used to suppress error messages if the config line
" references plugins/colorschemes that might be missing

" Make vim more useful
set nocompatible

" Point to location of pathogen submodule (since it's not in .vim/autoload)
silent! runtime .vim/bundle/vim-pathogen/autoload/pathogen.vim

" Call pathogen plugin management
silent! call pathogen#infect()

" Disable error bells
set noerrorbells
" Don’t show the intro message when starting vim
set shortmess=atI
" Show the filename in the window titlebar
set title
" don't wrap long lines
set nowrap
" try to enable reloading the current file if it was altered by another program, however this doesn't seem to work
set autoread

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    filetype indent on
    filetype plugin on

    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

if has("syntax")
    " Enable syntax highlighting
    syntax enable
    " Set 256 color terminal support
    set t_Co=256
    " Set dark background
    set background=dark
    " Set colorscheme
    colorscheme molokai
    let g:molokai_original = 1
endif

if has("cmdline_info")
    " Show the cursor line and column number
    set ruler
    " Show partial commands in status line
    set showcmd
    " Show whether in insert or replace mode
    set showmode
endif

if has('statusline')
    " Always show status line
    set laststatus=2
    " Broken down into easily includeable segments
    " Filename
    set statusline=%<%f\
    " Options
    set statusline+=%w%h%m%r
    " Current dir
    set statusline+=\ [%{getcwd()}]
    " Right aligned file nav info
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%
endif

if has("wildmenu")
    " Show a list of possible completions
    set wildmenu
    " Tab autocomplete longest possible part of a string, then list
    set wildmode=longest,list
    if has ("wildignore")
        set wildignore+=*.a,*.o
        set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
        set wildignore+=.DS_Store,.git,.hg,.svn
        set wildignore+=*~,*.swp,*.tmp
    endif
endif

if has("extra_search")
    " Highlight searches [use :noh to clear]
    set hlsearch
    " Highlight dynamically as pattern is typed
    set incsearch
    " Ignore case of searches...
    set ignorecase
    " ...unless has mixed case
    set smartcase
endif

" Add the g flag to search/replace by default
set gdefault

" Backspace through everything in INSERT mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Allow cursor keys in insert mode
set esckeys

" Make tabs as wide as four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Enable line numbers
set number

" Highlight current line
set cursorline

" Increase default number of lines
set lines=40

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show “invisible” characters
set list
" Set characters used to indicate 'invisible' characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" Change mapleader
let mapleader=","

" Don’t add empty newlines at the end of files
set binary
set noeol

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Enable mouse in all modes
silent! set mouse=a

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (,W)
" noremap <leader>W :w !sudo tee % > /dev/null<CR>
cmap w!! w !sudo tee >/dev/null %