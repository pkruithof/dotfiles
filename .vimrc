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

    " Languages with specific tabs/space requirements
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab

    " Automatically strip trailing whitespace on file save
    autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.php,*.py,*.rb,*.scss,*.sh,*.txt :call StripTrailingWhitespace()
endif

if has("syntax")
    " Enable syntax highlighting
    syntax enable
    " Set 256 color terminal support
    set t_Co=256
    " Set dark background
    set background=dark
    " Set colorscheme
    silent! colorscheme molokai
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
set listchars=tab:▸\
set listchars+=trail:·
set listchars+=nbsp:_
"set listchars+=eol:¬

" Change mapleader
let mapleader=","

" Don’t add empty newlines at the end of files
set binary
set noeol

" Centralize backups, swapfiles and undo history
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
if exists("&undodir")
  set undodir=$HOME/.vim/undo
endif
set viminfo+=n$HOME/.vim/.viminfo

" Enable mouse in all modes
silent! set mouse=a

" Strip trailing whitespace (,ss)
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (w!!)
cmap w!! w !sudo tee >/dev/null %

" Faster viewport scrolling (3 lines at a time)
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>