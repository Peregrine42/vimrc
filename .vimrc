" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" === PLUGINS ===
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'dbakker/vim-projectroot'
Plug 'tpope/vim-endwise'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'nlknguyen/papercolor-theme'
Plug 'scrooloose/nerdcommenter'
call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Leader key
let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" No errors!
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Encoding
set encoding=utf-8

" Whitespace
set nowrap
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs=

runtime! macros/matchit.vim
" Move up/down editor lines
nnoremap j gj
nnoremap k gk

inoremap `` <Esc>
nnoremap `` <Esc>

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" === here endeth basic config ===

let g:startify_custom_header =[]
let g:startify_bookmarks =['~/.vimrc']

map <Leader>m :NERDTreeToggle<CR>

" Always open NERDTree at project root
nnoremap <silent> <leader>M :ProjectRootExe NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" Autoclose vim if only thing left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NERDTree if a folder is opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <Leader>. :BufExplorer<CR>
map <Leader><Leader> :b#<CR>

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ----------------------------------------------
" Setup NERDCommenter
" ----------------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

autocmd vimenter * silent! lcd %:p:h

let g:mix_format_on_save = 1

" Auto move pwd to current directory
function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

autocmd BufEnter * call <SID>AutoProjectRootCD()

nmap <silent> <Leader>t :TestFile<CR>
nmap <silent> <Leader>T :TestLast<CR>

nmap <silent> <Leader>f :FZF<CR>

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

set dir=~/.vim/swapfiles

" Setup vim-startify's start screen
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 6
let g:startify_custom_header = [
      \"   Vim is charityware. Please read ':help uganda'",
      \ ]

let g:startify_list_order = [
      \ ['   Recent files in this directory:'],
      \ 'dir',
      \ ['   Recent files:'],
      \ 'files',
      \ ['   Bookmarks:'],
      \ 'bookmarks',
      \ ]

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ ]

let g:startify_bookmarks = [
      \ { 'v': '~/.vimrc' },
      \ ]

" Stop things splitting with Startify and replace it instead
autocmd User Startified setlocal buftype=

command W :w
command WQ :wq
command Wq :wq
command Q :q

autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:syntastic_java_checkers=['javac']
let g:syntastic_java_javac_config_file_enabled = 1

let g:vcm_omni_pattern = "Tab"

let g:ags_agcontext = 0

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>e :SyntasticCheck<CR> :SyntasticToggleMode<CR>
