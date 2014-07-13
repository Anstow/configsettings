set nocompatible

" Set the mouse to work
if has('mouse')
	set mouse=a
endif

set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline\ 10

syntax on

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

let $PYTHONPATH="/usr/lib/python3.4/site-packages"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Plugin Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails.git'
Plugin 'vim-scripts/DoxygenToolkit.vim.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'ap/vim-css-color.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tomasr/molokai.git'
Plugin 'mileszs/ack.vim'
" vim-scripts repos
Plugin 'L9'
"Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'taglist.vim'
" non github repos
Plugin 'git://git.wincent.com/command-t.git'
" ...

call vundle#end()
filetype plugin indent on     " required!
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Default options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This sets copy and paste clipboard to be the same as the highlighting
" clipboard
set clipboard=unnamed

set tabstop=4
set sw=4
set background=dark
colorscheme my_molokai
set encoding=utf-8

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" This will scroll the text when I get to within 15 lines of the edge of the
" window
set scrolloff=15
set showcmd
" This keeps files open in the background aftre they have been exited
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

" We wish to match angle brackets
set matchpairs+=<:> 

" Maps :W in normal mode to write a file using sudo, this has some extra code
" to automatically reload the file.
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Searching options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set incsearch
set showmatch
set ignorecase
set smartcase
set hlsearch
nnoremap <leader><space> :noh<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Line numbering
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This turns the relative line numbering on
set relativenumber

function! NumberToggle()
  if(&relativenumber == 1)
	set norelativenumber
    set number
  else
    set nonumber
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set nonumber
autocmd InsertLeave * :set relativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}} 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Qt commenting for DoxygenToolkit
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:DoxygenToolkit_startCommentTag = "/*! "
let g:DoxygenToolkit_startCommentBlock = "/* "

let g:DoxygenToolkit_briefTag_pre = "\\brief "
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
let g:DoxygenToolkit_paramTag_pre = "\\param "
let g:DoxygenToolkit_returnTag = "\\return "
let g:DoxygenToolkit_throwTag_pre = "\\throw " " \exception is also valid
let g:DoxygenToolkit_fileTag = "\\file "
let g:DoxygenToolkit_authorTag = "\\author "
let g:DoxygenToolkit_dateTag = "\\date "
let g:DoxygenToolkit_versionTag = "\\version "
let g:DoxygenToolkit_blockTag = "\\name "
let g:DoxygenToolkit_classTag = "\\class "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ ycm stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion = 1

" Temporary
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ File type stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cmake indenting and syntax highlighting
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim 
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

" Sets the file type for .as to action script.
au BufRead,BufNewFile *.as set filetype=actionscript 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" swapping the mappings for t and l to make things more ergonomic in Dvorak
" the left key is already h
"noremap h h
"noremap H H
" sets the up key to be t
"noremap t k
"noremap T K
"noremap gt gk
"noremap gT gK
"noremap zt zk
"noremap zT zK
"" sets the down key to be n
"noremap n j
"noremap N J
"noremap gn gj
"noremap gN gJ
"noremap zn zj
"noremap zN zJ
"" sets the right key to be s
"noremap s l
"noremap S L
"" sets the replace key to be l
"noremap l s
"noremap L S
"" set the next key to be k
"noremap k n
"noremap K N
"noremap gk gn
"noremap gK gN
"" sets the find letter key to be j
"noremap j t
"noremap J T
"noremap gk gt
"noremap gK gT
"let g:NERDTreeMapOpenInTab="h"
"let g:NERDTreeMapOpenInTabSilent="H"

set langmap=tk,TK,nj,NJ,sl,SL,ls,LS,kn,KN,jt,JT

" Sets Q to format text, this normally enter ex mode (visual mode)
map Q gq
" Makes yank more consitant with other vim commannds
noremap Y y$

" maps tab to match braket pairs
nnoremap <tab> %
vnoremap <tab> %

nnoremap <leader>k :NERDTree<CR>
nnoremap <leader>o :CommandT<CR>
nnoremap <leader>c :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>D :GoToDeclaration<CR>
nnoremap <leader>d :GoToDefinitionElseDeclaration<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ LaTeX stuff 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}} End of LaTeX stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim: foldmethod=marker
