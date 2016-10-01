set nocompatible

" Set the mouse to work
if has('mouse')
	set mouse=a
endif

if has("gui_running")
	set guifont=Hack\ 10
else
	set t_Co=256
endif

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

let g:powerline_pycmd="py3"


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
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-surround.git'
Plugin 'SirVer/ultisnips.git'
Plugin 'vim-scripts/DoxygenToolkit.vim.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'ap/vim-css-color.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tomasr/molokai.git'
Plugin 'mileszs/ack.vim.git'
Plugin 'rhysd/vim-grammarous.git'
Plugin 'godlygeek/tabular.git'
" Latex plugins
Plugin 'gi1242/vim-tex-syntax'
"Plugin 'vim-latex/vim-latex.git'
" vim-scripts repos
Plugin 'L9'
"Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
"Plugin 'taglist.vim'
" non github repos
Plugin 'git://git.wincent.com/command-t.git'
" ...

call vundle#end()
filetype plugin indent on     " required!
" To ignore plugin indent changes, instead use:
"filetype plugin on

syntax enable

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

" Disable bell when I type something that is technically not allowed.
autocmd VimEnter * set visualbell t_vb=

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
" This keeps files open in the background after they have been exited
set hidden
set wildmenu
set wildmode=list:longest
" cursorline has priority over spelling mistakes meaning that I miss them when
" typing in commandline mode.
if has("gui_running")
	set cursorline
endif
set ttyfast
set lazyredraw
set ruler
set backspace=indent,eol,start
set laststatus=2
set formatoptions+=j

set listchars=tab:>-,trail:·
set list

" We wish to match angle brackets
set matchpairs+=<:>

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Custom commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Maps :SudoWrite in normal mode to write a file using sudo, this has some extra code
" to automatically reload the file.
command SudoWrite :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Maps :DiffSaved to call make a diff with the saved version of the current
" file.
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

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

nnoremap <c-n> :call NumberToggle()<cr>

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
" {{{ Ack stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ackhighlight = 1
autocmd VimEnter * let g:ack_mappings = { "o": "<CR>" }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ ycm stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ ultisnips setup stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltisnipsUsePythonVersion = 3

let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

let g:UltiSnipsEditSnippet="horizontal"
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
" Sets the file type for .xpp to a cpp file
au BufRead,BufNewFile *.xpp set filetype=cpp
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
noremap n k
noremap N K
noremap gn gk
noremap gN gK
noremap zn zk
noremap zN zK
"noremap dn dk
"noremap dN dK
"noremap cn ck
"noremap cN cK
"noremap yn yk
"noremap yN yK
"noremap <n <k
"noremap <N <K
"noremap >n >k
"noremap >N >K
" sets the down key to be n
noremap t j
noremap T J
noremap gt gj
noremap gT gJ
noremap zt zj
noremap zT zJ
"noremap dt dj
"noremap dT dJ
"noremap ct cj
"noremap cT cJ
"noremap yt yj
"noremap yT yJ
"noremap <t <j
"noremap <T <J
"noremap >t >j
"noremap >T >J
" sets the right key to be s
noremap s l
noremap S L
"noremap ds dl
"noremap dS dL
"noremap cs cl
"noremap cS cL
"noremap ys yl
"noremap yS yL
"noremap <s <l
"noremap <S <L
"noremap >s >l
"noremap >S >L
" sets the replace key to be l
noremap l s
noremap L S
" set the next key to be k
noremap k n
noremap K N
"noremap gk gn
"noremap gK gN
" sets the find letter key to be j
noremap j t
noremap J T
"noremap gk gt
"noremap gK gT
let g:NERDTreeMapOpenInTab="h"
let g:NERDTreeMapOpenInTabSilent="H"

"if (exists('+langremap'))
"	set nolangremap
"elseif (exists("+langnoremap"))
"	set langnoremap
"endif
"set langmap=tk,TK,nj,NJ,sl,SL,ls,LS,kn,KN,jt,JT

" Sets Q to format text, this normally enter ex mode (visual mode)
map Q gq
" Makes yank more consitant with other vim commannds
noremap Y y$

" Preserve highlighting in visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" maps tab to match braket pairs
nnoremap <tab> %
vnoremap <tab> %
nnoremap y<tab> y%
nnoremap d<tab> d%
nnoremap c<tab> c%

" map ; to execute a command
nnoremap ; :
vnoremap ; :
" map : to repeat reverse find char
nnoremap : ,
vnoremap : ,
" map , to repeat forward find char
nnoremap , ;
vnoremap , ;

nnoremap <leader>o :NERDTree<CR>
nnoremap <leader>t :CommandT<CR>
nnoremap <leader>c :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>f :YcmCompleter FixIt<CR>
nnoremap <leader>D :GoToDeclaration<CR>
nnoremap <leader>d :GoToDefinitionElseDeclaration<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ LaTeX stuff 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Starting with Vim 7, the filetype of empty .tex files defaults to 'plaintex'
" instead of 'tex', which results in incorrect syntax highlighting. As I only
" work with LaTeX files, the following changes the default filetype back to
" 'tex':
let g:tex_flavor='latex'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}} End of LaTeX stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim: foldmethod=marker
