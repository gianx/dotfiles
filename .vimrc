" UI Config

syntax enable
colorscheme distinguished

set number
set showmode
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set foldenable
set foldlevelstart=10
set foldnestmax=10
set expandtab
set mouse=a
set laststatus=2
set backspace=indent,eol,start
set errorbells
set visualbell
set autoindent

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]

" Encoding

set encoding=utf-8

" Searching

set incsearch
set hlsearch
set ignorecase

" Spaces and tabs

set tabstop=4
set softtabstop=4
set expandtab

" Remaps

nnoremap j gj
nnoremap k gk

" turn hybrid line numbers on
:set number relativenumber
:set nu rnu
