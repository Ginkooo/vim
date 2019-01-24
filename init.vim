" Copyright (C) 2018  Piotr Czajka <czajka@protonmail.com>
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

set nocompatible
filetype plugin on

filetype plugin indent on

set nobackup
set noswapfile

set history=200

set shell=/bin/bash


cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

set completeopt=noinsert,menuone,noselect


call plug#begin()
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'heavenshell/vim-jsdoc'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'heavenshell/vim-pydocstring'
Plug 'tobyS/pdv'
Plug 'Valloric/MatchTagAlways'
Plug 'antoyo/vim-licenses'
Plug 'Valloric/MatchTagAlways'
Plug 'mattn/emmet-vim'
Plug 'farfanoide/vim-kivy'
Plug 'tpope/vim-commentary'
Plug 'wesQ3/vim-windowswap'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go'
Plug 'stevearc/vim-arduino'
Plug 'lervag/vimtex' "Latex things, like \ll for continuous compilation
Plug 'ervandew/supertab'
Plug 'Chiel92/vim-autoformat'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'bling/vim-bufferline'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

call plug#end()

let g:SuperTabClosePreviewOnPopupClose = 1 "close preview window on completion done

"Gitgutter configuration----------------------------------------------------
let g:gitgutter_map_keys = 0 "turn off default mappings
"end of git gutter configuration--------------------------------------------


"ALE configuration-----------------------------------------------------------
let g:ale_linters = {'rust': ['rls', 'cargo', 'rustc']}
"end of ALE configuration----------------------------------------------------


"Vimtex configuration--
let g:vimtex_enabled = 1
let g:vimtex_view_general_viewer = 'okular'

"supertab configuration---------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>" "choose items from top to bottom

"EVENTS--------------------------------------------------------------------

"As PEP8 hints
autocmd InsertEnter *.py :set colorcolumn=80
autocmd InsertLeave *.py :set colorcolumn&

"END OF EVENTS-------------------------------------------------------------

function! MyOnBattery()
    "detect if on battery source or not
    let l:path = '/sys/class/power_supply/AC/online'
    let l:readable = filereadable(l:path)
    if l:readable == 0
        return 1
    endif
    return readfile(l:path) == ['0']
endfunction

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

" windowswap mappings
nnoremap <silent> <silent> <A-S-H> :call WindowSwap#EasyWindowSwap()<CR><C-w>h:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <silent> <A-S-J> :call WindowSwap#EasyWindowSwap()<CR><C-w>j:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <silent> <A-S-K> :call WindowSwap#EasyWindowSwap()<CR><C-w>k:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <silent> <A-S-L> :call WindowSwap#EasyWindowSwap()<CR><C-w>l:call WindowSwap#EasyWindowSwap()<CR>


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
command F Autoformat


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


nnoremap <silent> <F1> <nop>
imap <F1> <nop>
vmap <F1> <nop>

vmap <leader>y "+y
vmap <leader>d "+d
vmap <leader>pp "+p
vmap <leader>Pp "+P
nnoremap <silent> <leader>pp "+p
nnoremap <silent> <leader>Pp "+P

nnoremap <silent> <F2> :w<CR>i<ESC>
imap <F2> <ESC>:w<CR>

nnoremap <silent> <F3> :Autoformat<CR>

map <leader>n :NERDTreeToggle<CR>

nnoremap <silent> B ^
nnoremap <silent> E $

nnoremap <silent> $ <nop>
nnoremap <silent> ^ <nop>

nnoremap <silent> <CR> G

nnoremap <silent> <leader>= <C-W>=

nnoremap <silent> <leader>k :bnext<CR>
nnoremap <silent> <leader>j :bprevious<CR>
nnoremap <silent> <leader>q :bdelete<CR>
nnoremap <silent> <leader>d :call WriteDocstring()<CR>
nnoremap <silent> <leader>v :vsplit<CR>
nnoremap <silent> <leader>h :split<CR>
nnoremap <silent> <leader>, :close<CR>


inoremap <silent>  <A-h> <C-\><C-N><C-w>h
inoremap <silent>  <A-j> <C-\><C-N><C-w>j
inoremap <silent>  <A-k> <C-\><C-N><C-w>k
inoremap <silent>  <A-l> <C-\><C-N><C-w>l
nnoremap <silent>  <A-h> <C-w>h
nnoremap <silent>  <A-j> <C-w>j
nnoremap <silent>  <A-k> <C-w>k
nnoremap <silent>  <A-l> <C-w>l

nnoremap <silent>  <A-f> :vertical resize +5<CR>
nnoremap <silent>  <A-a> :vertical resize -5<CR>
nnoremap <silent>  <A-d> :resize +5<CR>
nnoremap <silent>  <A-s> :resize -5<CR>


" movement inkquickfix
nnoremap <silent>  <leader>; :grep! "\b<C-R><C-W>\b" *<CR>:cw<CR>
nnoremap <silent>  [q :cprev<CR>
nnoremap <silent>  ]q :cnext<CR>
nnoremap <silent>  [Q :cfirst<CR>
nnoremap <silent>  ]Q :clast<CR>

nnoremap <silent>  <C-J> <C-F>
nnoremap <silent>  <C-K> <C-B>

au VimEnter * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

map <F11> <ESC>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR><leader>=

map <C-O> o<ESC>ko

vmap v <plug>(expand_region_expand)
vmap <C-V> <plug>(expand_region_shrink)

nnoremap <silent> <TAB> %
vnoremap <TAB> %

inoremap jj <ESC>

let g:UltiSnipsExpandTrigger =  'nothing'


nnoremap <silent> <leader>i :Gpl<CR>
let g:licenses_copyright_holders_name = 'Piotr Czajka <czajka@protonmail.com>'
let g:licenses_authors_name = 'Piotr Czajka <czajka@protonmail.com>'


set tabstop=4
set shiftwidth=4
set expandtab
set smarttab


set wildmenu
set wildmode=full

"filetype specific keymaps
autocmd FileType python nnoremap <silent> <leader>pd oimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType python nnoremap <silent> <leader>Pd Oimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType html set tabstop=2
autocmd FileType html set shiftwidth=2
autocmd FileType vue set tabstop=2
autocmd FileType vue set shiftwidth=2
autocmd FileType javascript.jsx set tabstop=2
autocmd FileType javascript.jsx set shiftwidth=2

autocmd FileType go nnoremap <silent> <F9> :!go run %<CR>
autocmd FileType go inoremap <silent> <F9> <ESC>:!go run %<CR>
autocmd FileType python nnoremap <silent> <F9> :!python %<CR>
autocmd FileType python inoremap <silent> <F9> <ESC>:!python %<CR>

"real lines and display lines
nnoremap <silent> k gk
nnoremap <silent> gk k
nnoremap <silent> j gj
nnoremap <silent> gj j


" move words under home row
nnoremap <silent> H b
nnoremap <silent> L w

" maximaze/restore window
nnoremap <silent> <A-m> :MaximizerToggle!<CR>

nnoremap <silent> <leader>. :pclose<CR>

"git key bindings
nnoremap <silent> <leader>ghs <ESC>:GitGutterStageHunk<CR>
nnoremap <silent> <leader>ghu <ESC>:GitGutterUndoHunk<CR>
nnoremap <silent> <leader>ghp <ESC>:GitGutterPreviewHunk<CR>
nnoremap <silent> <leader>gdm :Gdiff master<CR>

"toggling things
nnoremap <silent> <leader>tt :split<CR>:term<CR>
nnoremap <silent> <leader>ta :ALEToggle<CR>

"other
nnoremap <silent> <leader>n :NERDTreeToggle<CR>

map <silent> <A-u> <C-u>
map <silent> <A-d> <C-d>


"Language server config

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

autocmd BufEnter  *  call ncm2#enable_for_buffer()

let g:LanguageClient_serverCommands = {
    \ 'python': [system('which pyls')[0:-2], '--log-file', '/tmp/pyls_log.txt', '-vvvvvv'],
    \ 'cpp': [system('which cquery')[0:-2]]
    \ }

let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>
