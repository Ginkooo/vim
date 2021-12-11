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
set nospell
set clipboard=unnamedplus

set history=200

set shell=/bin/bash
set foldlevel=99

syntax on

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

set completeopt=noinsert,menuone,noselect


call plug#begin()
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'pseewald/vim-anyfold'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'heavenshell/vim-jsdoc'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'heavenshell/vim-pydocstring', {'do': 'make install'}
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
Plug 'stevearc/vim-arduino'
Plug 'lervag/vimtex' "Latex things, like \ll for continuous compilation
Plug 'ervandew/supertab'
Plug 'Chiel92/vim-autoformat'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'bling/vim-bufferline'
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/vim-preview'
Plug 'christoomey/vim-system-copy'

call plug#end()


let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

let g:SuperTabClosePreviewOnPopupClose = 1 "close preview window on completion done

"Gitgutter configuration----------------------------------------------------
let g:gitgutter_map_keys = 0 "turn off default mappings
"end of git gutter configuration--------------------------------------------

let g:pydocstring_doq_path = "/usr/bin/doq"


let g:tex_flavor = 'latex'


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
nnoremap <silent> <silent> <ALT-S-H> :call WindowSwap#EasyWindowSwap()<CR><C-w>h:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <silent> <ALT-S-J> :call WindowSwap#EasyWindowSwap()<CR><C-w>j:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <silent> <ALT-S-K> :call WindowSwap#EasyWindowSwap()<CR><C-w>k:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <silent> <ALT-S-L> :call WindowSwap#EasyWindowSwap()<CR><C-w>l:call WindowSwap#EasyWindowSwap()<CR>


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
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_custom_ignore = 'node_modules'


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
set statusline+=%{coc#status()}

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

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"


inoremap <M-h> <C-w>h
inoremap <M-j> <C-w>j
inoremap <M-k> <C-w>k
inoremap <M-l> <C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <M-f> :vertical resize +5<CR>
nnoremap <M-a> :vertical resize -5<CR>
nnoremap <M-d> :resize +5<CR>
nnoremap <M-s> :resize -5<CR>


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
autocmd Filetype * AnyFoldActivate
autocmd FileType python nnoremap <silent> <leader>pd oimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType python nnoremap <silent> <leader>Pd Oimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType html set tabstop=2
autocmd FileType html set shiftwidth=2
autocmd FileType vue set tabstop=2
autocmd FileType vue set shiftwidth=2
autocmd FileType javascript.jsx set tabstop=2
autocmd FileType javascript.jsx set shiftwidth=2

autocmd FileType go nnoremap <silent> <F9> :!go run *.go<CR>
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


let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/bin/pyls', '--log-file', '/tmp/pyls_log.txt', '-vvvvvv'],
    \ 'cpp': [system('which cquery')[0:-2], '--log-file', '/tmp/cquery.log'],
    \ 'go': [system('which go-langserver')[0:-2], '-gocodecompletion', '-lint-tool', 'golint'],
    \ 'rust': [system('which rls')[0:-2]]
    \ }

let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile =  expand('~/.local/share/vim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/vim/LanguageServer.log')

nmap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lu <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
