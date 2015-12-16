set nocompatible 
" ================ General Config ====================

set number                      "show line number
set so=999
set showcmd                     "show incomplete cmds at bottom
set showmode                    "show current mode at bottom
set cursorline                  "highlight the line cursor is on
set gcr=a:blinkon0              "no cursor blink
set visualbell                  "no sounds
set hlsearch                    "highlight search
set omnifunc=syntaxcomplete#Complete
syntax on
let mapleader=','               "\x to ,x
let maplocalleader='\\'            "local leader

" ================ Vundle Setup ====================

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'tpope/vim-fugitive'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'wincent/command-t'
Bundle 'ervandew/supertab'
Bundle 'kien/rainbow_parentheses.vim'
Plugin 'derekwyatt/vim-scala'

call vundle#end()
filetype plugin indent on

" ================ Turn Off Swap Files ====================

set noswapfile
set nobackup
set nowb

" ================ Window ===================

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" ================ Indentation ====================

" set autoindent
" set smartindent
set smarttab
set shiftwidth=2
" set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set wrap

" ================ Folds ====================

set foldmethod=indent               "fold based on indent
set foldnestmax=1                   "deepest fold is 3 levels
set nofoldenable                    "dont fold by default

" ================ Custom ====================

nnoremap <esc> :noh<return><esc>

" ================ Plugins ====================
" --------------- python-mode setup ------------------
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Increase max line length
let g:pymode_options_max_line_length = 120
