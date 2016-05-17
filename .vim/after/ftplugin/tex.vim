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
" Greek letter maps
inoremap `a \alpha
inoremap `b \beta
inoremap `g \gamma
inoremap `G \Gamma
inoremap `d \delta
inoremap `e \epsilon
inoremap `z \zeta
inoremap `k \eta
" Note langmap cause the t key to work like j
inoremap `jh \theta
" Note langmap cause the T key to work like J
inoremap `Jh \Theta
inoremap `i \iota
" Note langmap causes the k key to work like t
inoremap `t \kappa
" Note langmap causes the s key to work like l
inoremap `s \lambda
inoremap `S \Lambda
inoremap `m \mu
inoremap `v \nu
inoremap `p \pi
inoremap `P \pi
inoremap `r \rho
" Note langmap causes the l key to work like s
inoremap `l \sigma
" Note langmap causes the L key to work like S
inoremap `L \Sigma
" Note langmap cause the t key to work like j
inoremap `t \tau
inoremap `u \upsilon
inoremap `f \phi
inoremap `F \Phi
inoremap `x \chi
inoremap `ps \psi
inoremap `Ps \Psi
inoremap `w \omega
inoremap `W \Omega
