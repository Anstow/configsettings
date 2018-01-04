" Non-Latex Suite Mappings
function! CompileLatex() 
  :w
  " Only write run latex if the file includes a begin document line, otherwise
  " it isn't a compilable tex file.
  if (search('\\begin{document}', 'nw') != 0)
    :silent !latexmk -pdf % >/dev/null 2>&1 &
  endif
  :redraw!
endfunc

function! ViewPdf()
  if (search('\\begin{document}', 'nw') != 0)
    :silent !evince %:r.pdf >/dev/null 2>&1 &
  endif
endfunc

setlocal sw=2
setlocal ts=2

setlocal linebreak

setlocal spell
setlocal spelllang=en_gb
setlocal spellfile=$HOME/.vim/spell/maths.utf-8.add

" Only set spell syntax to toplevel if there isn't a begin document line
if (search('\\begin{document}', 'nw') == 0)
	syntax spell toplevel
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key maps
" Normal mode maps
nnoremap <leader>c :call CompileLatex()<CR>
nnoremap <leader>v :call ViewPdf()<CR>

" Insert mode maps

inoremap `< \langle
inoremap `> \rangle
inoremap `- \overline
inoremap `c \centre

" Greek letter maps
inoremap `a \alpha
inoremap `b \beta
inoremap `g \gamma
inoremap `G \Gamma
inoremap `d \delta
inoremap `D \Delta
inoremap `e \epsilon
inoremap `z \zeta
" Note langmap cause the j key to work like n
inoremap `n \eta
" Note langmap cause the k key to work like t
inoremap `th \theta
" Note langmap cause the K key to work like T
inoremap `Kh \Theta
inoremap `i \iota
" Note langmap causes the n key to work like k
inoremap `k \kappa
" Note langmap causes the s key to work like l
inoremap `l \lambda
" Note langmap causes the S key to work like L
inoremap `L \Lambda
inoremap `m \mu
inoremap `v \nu
" Note langmap causes the n key to work like k and l key to work like s
inoremap `ks \xi
inoremap `p \pi
inoremap `P \pi
inoremap `r \rho
" Note langmap causes the l key to work like s
inoremap `s \sigma
" Note langmap causes the L key to work like S
inoremap `S \Sigma
" Note langmap cause the k key to work like t
inoremap `t \tau
inoremap `u \upsilon
inoremap `f \phi
inoremap `F \Phi
inoremap `x \chi
" Note langmap causes the l key to work like s
inoremap `ps \psi
" Note langmap causes the l key to work like s
inoremap `Ps \Psi
inoremap `w \omega
inoremap `W \Omega
