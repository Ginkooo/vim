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

set history=200

set shell=/bin/bash


cnoremap <C-p> <Up>
cnoremap <C-n> <Down>


call plug#begin()

Plug 'neomake/neomake'
Plug 'sjl/badwolf'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'heavenshell/vim-jsdoc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'ap/vim-css-color'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'heavenshell/vim-pydocstring'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'SirVer/ultisnips' snipetts in vim, useful to learn
Plug 'tobyS/pdv'
Plug 'Valloric/MatchTagAlways'
Plug 'antoyo/vim-licenses'
Plug 'Valloric/MatchTagAlways'
Plug 'rust-lang/rust.vim'
Plug 'mattn/emmet-vim'
Plug 'farfanoide/vim-kivy'
Plug 'maralla/completor.vim'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-commentary'

call plug#end()

function! MyOnBattery()
    let l:path = '/sys/class/power_supply/AC/online'
    let l:readable = filereadable(l:path)
    if l:readable == 0
        return 1
    endif
    return readfile(l:path) == ['0']
endfunction

if MyOnBattery()
  call neomake#configure#automake('nw', 2000)
else
  call neomake#configure#automake('nw', 100)
endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

autocmd CompleteDone * silent! pclose!
" Close window after completion


:tnoremap <Esc> <C-\><C-n>


" jedi-vim
let g:jedi#usages_command = "<leader>u"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_command = "<leader>gd"

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





" Hex editor vim
let b:hexmode = 0
function ToggleHexMode()
    if (b:hexmode == 0)
        %!xxd
        let b:hexmode = 1
    else
        %!xxd -r
        let b:hexmode = 0
    endif
endfunction


command Hex call ToggleHexMode()


"emmet config
let g:user_emmet_leader_key='<leader>f'
let g:user_emmet_mode='n'


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

nnoremap <leader>= <C-W>=

nnoremap <leader>t :split<CR>:terminal<CR>a
nnoremap <leader>T :vsplit<CR>:terminal<CR>a
nnoremap <leader>k :bnext<CR>
nnoremap <leader>j :bprevious<CR>
nnoremap <leader>q :bdelete<CR>
nnoremap <leader>d :call WriteDocstring()<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
nnoremap <leader>, :close<CR>


tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l


nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <A-f> :vertical resize +5<CR>
nnoremap <A-a> :vertical resize -5<CR>
nnoremap <A-d> :resize +5<CR>
nnoremap <A-s> :resize -5<CR>
nnoremap <A-f> :vertical resize +5<CR>
nnoremap <A-a> :vertical resize -5<CR>
nnoremap <A-d> :resize +5<CR>
nnoremap <A-s> :resize -5<CR>

" movement inkquickfix
nmap <leader>; :grep! "\b<C-R><C-W>\b" *<CR>:cw<CR>
nmap [q :cprev<CR>
nmap ]q :cnext<CR>
nmap [Q :cfirst<CR>
nmap ]Q :clast<CR>

nmap <C-J> <C-F>
nmap <C-K> <C-B>

au VimEnter * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

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


set tabstop=4
set shiftwidth=4
set expandtab
set smarttab


set wildmenu
set wildmode=full
