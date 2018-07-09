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


call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sjl/badwolf'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'heavenshell/vim-jsdoc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'heavenshell/vim-pydocstring'
" Plug 'SirVer/ultisnips' snipetts in vim, useful to learn
Plug 'tobyS/pdv'
Plug 'Valloric/MatchTagAlways'
Plug 'antoyo/vim-licenses'
Plug 'Valloric/MatchTagAlways'
Plug 'rust-lang/rust.vim'
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
Plug 'w0rp/ale' "code linting
Plug 'tweekmonster/django-plus.vim' "completion and highliting for django
Plug 'farfanoide/vim-kivy' "highliting for kivy
Plug 'pangloss/vim-javascript' "syntax highlighting for JS
Plug 'ervandew/supertab' "use tab for choosing completions
Plug 'mxw/vim-jsx' "syntax highliting for JSX (That React virtual DOM syntax)
Plug 'Integralist/vim-mypy' "python type check under :Mypy
Plug 'davidhalter/jedi-vim' " for go to implementation in python etc. this doesn't do autocompletion
Plug 'maralla/completor.vim' " completion engine
Plug 'rust-lang/rust.vim' "support for rust filetype in vim
Plug 'racer-rust/vim-racer' "rust code navigation. It has code completion features, but they are not used, as completor handles everything
Plug 'posva/vim-vue' "Syntax highliting for vue.js projects

call plug#end()

let g:SuperTabClosePreviewOnPopupClose = 1 "close preview window on completion done

"Gitgutter configuration----------------------------------------------------
let g:gitgutter_map_keys = 0 "turn off default mappings
"end of git gutter configuration--------------------------------------------

"vim-racer configuration
au FileType rust nmap <leader>gd <Plug>(rust-def)
au FileType rust nmap <leader>K <Plug>(rust-doc)
"end of vim-racer configuration


"ALE configuration-----------------------------------------------------------
let g:ale_linters = {'rust': ['rls', 'cargo', 'rustc']}
"end of ALE configuration----------------------------------------------------


"completor configuration------------------------------------------------------
"end of completor configuration-----------------------------------------------


"Vimtex configuration--
let g:vimtex_enabled = 1
let g:vimtex_view_general_viewer = 'okular'

"supertab configuration---------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>" "choose items from top to bottom

"jedi-vim configuration---------------------------------------------------
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<leader>gi"
let g:jedi#goto_assignments_command = "<leader>ga"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>gu"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
"END OF JEDI CONFIGURATION ------------------------------------------------

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
nnoremap <silent> <A-S-H> :call WindowSwap#EasyWindowSwap()<CR><C-w>h:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <A-S-J> :call WindowSwap#EasyWindowSwap()<CR><C-w>j:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <A-S-K> :call WindowSwap#EasyWindowSwap()<CR><C-w>k:call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <A-S-L> :call WindowSwap#EasyWindowSwap()<CR><C-w>l:call WindowSwap#EasyWindowSwap()<CR>


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


nnoremap <F1> <nop>
imap <F1> <nop>
vmap <F1> <nop>

vmap <leader>y "+y
vmap <leader>d "+d
vmap <leader>pp "+p
vmap <leader>Pp "+P
nnoremap <leader>pp "+p
nnoremap <leader>Pp "+P

nnoremap <F2> :w<CR>
imap <F2> <ESC>:w<CR>

nnoremap <silent> <F3> :set hlsearch!<CR>

map <leader>n :NERDTreeToggle<CR>

nnoremap B ^
nnoremap E $

nnoremap $ <nop>
nnoremap ^ <nop>

nnoremap <CR> G

nnoremap <leader>= <C-W>=

nnoremap <leader>k :bnext<CR>
nnoremap <leader>j :bprevious<CR>
nnoremap <leader>q :bdelete<CR>
nnoremap <leader>d :call WriteDocstring()<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
nnoremap <leader>, :close<CR>


"window movement
execute "set <M-h>=\eh"
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
execute "set <M-l>=\el"
execute "set <M-a>=\ea"
execute "set <M-s>=\es"
execute "set <M-d>=\ed"
execute "set <M-f>=\ef"

inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <M-f> :vertical resize +5<CR>
nnoremap <M-a> :vertical resize -5<CR>
nnoremap <M-d> :resize +5<CR>
nnoremap <M-s> :resize -5<CR>


" movement inkquickfix
nnoremap <leader>; :grep! "\b<C-R><C-W>\b" *<CR>:cw<CR>
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

nnoremap <C-J> <C-F>
nnoremap <C-K> <C-B>

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

"filetype specific keymaps
autocmd FileType python nnoremap <leader>pd oimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType python nnoremap <leader>Pd Oimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType html set tabstop=2
autocmd FileType html set shiftwidth=2
autocmd FileType vue set tabstop=2
autocmd FileType vue set shiftwidth=2
autocmd FileType javascript.jsx set tabstop=2
autocmd FileType javascript.jsx set shiftwidth=2

"real lines and display lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j


" move words under home row
nnoremap H b
nnoremap L w

" maximaze/restore window
nnoremap <A-m> :MaximizerToggle!<CR>

nnoremap <leader>. :pclose<CR>

"git key bindings
nnoremap <leader>ghs <ESC>:GitGutterStageHunk<CR>
nnoremap <leader>ghu <ESC>:GitGutterUndoHunk<CR>
nnoremap <leader>ghp <ESC>:GitGutterPreviewHunk<CR>
nnoremap <leader>gdm :Gdiff master<CR>

"toggling things
nnoremap <leader>tt :split<CR>:term<CR>
nnoremap <leader>ta :ALEToggle<CR>
