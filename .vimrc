" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" === PLUGINS ===
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'wellle/targets.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-projectionist'
Plug 'andyl/vim-projectionist-elixir'
Plug 'scrooloose/nerdcommenter'
Plug 'farmergreg/vim-lastplace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dbakker/vim-projectroot'
Plug 'tpope/vim-endwise'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

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
set textwidth=79
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

" 24-bit color!
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme onedark

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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Projectionist defaults
let g:projectionist_heuristics ={
      \  "spec/*.rb": {
      \     "app/*.rb":       {"alternate": "spec/{}_spec.rb",         "type": "source"},
      \     "lib/*.rb":       {"alternate": "spec/{}_spec.rb",         "type": "source"},
      \     "spec/*_spec.rb": {"alternate": ["app/{}.rb","lib/{}.rb"], "type": "test"}
      \  }
      \}


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
      \ { 'v': '~/.vim/.vimrc' },
      \ ]

" Stop things splitting with Startify and replace it instead
autocmd User Startified setlocal buftype=

command W :w
command WQ :wq
command Wq :wq
