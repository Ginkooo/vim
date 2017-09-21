set autochdir

set nocompatible
filetype plugin on

filetype plugin indent on

set nobackup
set noswapfile

set shell=/bin/bash

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

autocmd CompleteDone * silent! pclose!
" Close window after completion


call plug#begin()

Plug 'W0rp/ale'
Plug 'sjl/badwolf'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdtree'
Plug 'heavenshell/vim-jsdoc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'ap/vim-css-color'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'heavenshell/vim-pydocstring'
Plug 'mhinz/vim-startify'

call plug#end()



function! WriteDocstring()
	if (&ft=='python')
		:Pydocstring
	endif

	if (&ft=='javascript')
		:JsDoc
	endif
endfunction



let g:deoplete#sources#ternjs#docs = 1


let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#jedi#show_docstring = 1

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


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
set undodir=~/.vim/undo


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

nnoremap <leader>t :enew<CR>
nnoremap <leader>k :bnext!<CR>
nnoremap <leader>j :bprevious!<CR>
nnoremap <leader>q :bp <BAR> bd #<CR>
map <leader>e <ESC>:bd<CR>
nnoremap <leader>d :call WriteDocstring()<CR>
nnoremap <leader>m :vsplit<CR>
nnoremap <leader>[ :vertical resize +10<CR>
nnoremap <leader>] :vertical resize -10<CR>
nnoremap <leader>, <C-w>q
nnoremap <leader>U <C-w>k
nnoremap <leader>M <C-w>j

" movement in quickfix
nmap <leader>; :grep! "\b<C-R><C-W>\b" *<CR>:cw<CR>
nmap [q :cprev<CR>
nmap ]q :cnext<CR>
nmap [Q :cfirst<CR>
nmap ]Q :clast<CR>

nmap <C-J> <C-F>
nmap <C-K> <C-B>

map <F11> <ESC>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR><leader>=

map <C-O> o<ESC>ko

vmap v <plug>(expand_region_expand)
vmap <C-V> <plug>(expand_region_shrink)

nnoremap <TAB> %
vnoremap <TAB> %

inoremap jj <ESC>
