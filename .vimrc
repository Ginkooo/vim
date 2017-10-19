" Copyright (C) 2017  Piotr Czajka <czajka@protonmail.com>
" Author: Piotr Czajka <czajka@protonmail.com>
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.

set autochdir

set nocompatible
filetype plugin on

filetype plugin indent on

set nobackup
set noswapfile

set shell=/bin/bash



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
Plug 'heavenshell/vim-pydocstring'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install -g tern' }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mhinz/vim-startify'
Plug 'SirVer/ultisnips'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
Plug 'Valloric/MatchTagAlways'
Plug 'antoyo/vim-licenses'
Plug 'Valloric/MatchTagAlways'
Plug 'rust-lang/rust.vim'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-clang'

call plug#end()


inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

autocmd CompleteDone * silent! pclose!
" Close window after completion



" Clang deoplete config
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'


function! WriteDocstring()
	if (&ft=='python')
		Pydocstring
	endif

	if (&ft=='javascript')
		JsDoc
	endif

    if (&ft=='php')
        call pdv#DocumentWithSnip()
    endif

    if (&ft=='cpp')
        Dox
    endif

    if (&ft=='c')
        Dox
    endif
endfunction



" RUST CONFIG
let g:deoplete#sources#rust#racer_binary = $HOME . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = '/opt/rust/src'
"let g:deoplete#sources#rust#disable_keymap = 1
let g:deoplete#sources#rust#documentation_max_height = 20
let g:ale_linters = {'rust': ['rls', 'rustc']}
let g:ale_rust_rls_executable = $HOME . '/.cargo/bin/rls'


let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#types = 1


let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#jedi#show_docstring = 1

let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"

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

set expandtab
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

let g:UltiSnipsExpandTrigger =  'nothing'


nnoremap <leader>i :Gpl<CR>
let g:licenses_copyright_holders_name = 'Piotr Czajka <czajka@protonmail.com>'
let g:licenses_authors_name = 'Piotr Czajka <czajka@protonmail.com>'
