set autochdir

set nocompatible
filetype plugin on

filetype plugin indent on

set nobackup
set noswapfile

set shell=/bin/bash

let g:completor_python_binary = '/usr/local/bin/python3.6'
let g:completor_node_binary = '/usr/bin/node'
let g:completor_clang_binary = '/usr/bin/clang'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#right_sep=''
let g:airline#extensions#bufferline#enabled=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'

colorscheme badwolf
set guifont=Hack:h8:cEASTEUROPE
let g:badwolf_darkgutter=1
set guioptions-=r
set guioptions-=L

let mapleader="\<Space>"
set guiheadroom=0
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8

set autoindent
set smartindent

set shiftwidth=4
set tabstop=4

syntax on

set number
set relativenumber

set backspace=indent,eol,start

set ignorecase
set smartcase
set incsearch
set hlsearch!

set ruler

set showcmd

set cursorline

set lazyredraw

set list listchars=tab:\ \ ,trail:@

set laststatus=2

set guioptions-=T

set autoread

set clipboard+=unnamed

set shortmess+=I

set splitbelow
set splitright

set guioptions-=m

set scrolloff=3

set gdefault

set hidden
set undofile
set undodir=/home/pczajka/.vim/undo


nmap <F1> <nop>
imap <F1> <nop>
vmap <F1> <nop>

vmap <leader>y "+y
vmap <leader>d "+d
vmap <leader>p "+p
vmap <leader>P "+P
nmap <leader>p "+p
nmap <leader>P "+P

nmap <F2> :w<CR>
imap <F2> <ESC>:w<CR>

nnoremap <silent> <F3> :set hlsearch!<CR>

map <leader>n :NERDTreeToggle<CR>

nnoremap B ^
nnoremap E $

nnoremap $ <nop>
nnoremap ^ <nop>

nnoremap <CR> G

nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>= <C-W>=

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nmap <leader>t <F2>:enew<CR>
nmap <leader>k :bnext!<CR>
nmap <leader>j :bprevious!<CR>
nmap <leader>q <F2>:bp <BAR> bd #<CR>
map <leader>e <ESC>:bd<CR>
nmap <leader>i :Pydocstring<CR>
nmap <leader>d :Dox<CR>

nmap <C-J> <C-F>
nmap <C-K> <C-B>

map <F11> <ESC>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR><leader>=

map <C-O> o<ESC>ko

vmap v <plug>(expand_region_expand)
vmap <C-V> <plug>(expand_region_shrink)

map <leader>u :BufstopFast<CR>

nnoremap <TAB> %
vnoremap <TAB> %

inoremap jj <ESC>
noremap zz :wq<CR>


nmap <leader>f :Autoformat<CR>
