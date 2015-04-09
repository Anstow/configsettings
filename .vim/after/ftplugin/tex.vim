" Non-Latex Suite Mappings
function! CompileLatex() 
  :w
  :silent !latexmk -pdf % >/dev/null 2>&1 &
  :redraw!
endfunc

nnoremap <leader>c :call CompileLatex()<CR>

set sw=2
set ts=2
