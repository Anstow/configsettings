" Non-Latex Suite Mappings
function! CompileLatex() 
  :w
  " Only write run latex if the file includes a begin document line, otherwise
  " it isn't a valid tex file.
  if (search('\\begin{document}', 'nw') != 0)
	  :silent !latexmk -pdf % >/dev/null 2>&1 &
  endif
  :redraw!
endfunc

nnoremap <leader>c :call CompileLatex()<CR>

set sw=2
set ts=2

let &l:formatlistpat='^\s*\\\(end\|item\)\>'
setlocal formatoptions+=n
