lua require("config.lazy")

" LaTeX Keymaps
augroup latex_keymaps
  " Compile to PDF with Key
  " autocmd FileType tex nnoremap <buffer> <leader><F11> :!pdflatex %:p<CR>
  " autocmd FileType markdown nnoremap <buffer> <leader><F11> :!pandoc %:p -o %:p:r.pdf --pdf-engine=xelatex -V mainfont='Trebuchet MS' -V geometry:margin=1.0in<CR>

  " Auto Run Compilation After Saving Document
  autocmd FileType tex autocmd BufWritePost <buffer> silent! execute '!nohup pdflatex %:p > /dev/null 2>&1 &'
  autocmd FileType markdown autocmd BufWritePost <buffer> silent! execute '!pandoc %:p -o %:p:r.pdf --pdf-engine=xelatex -V mainfont="Trebuchet MS" -V geometry:margin=1.0in &'

  " Open File in PDF Viewer
  autocmd FileType tex,markdown nnoremap <buffer> <leader><F12> :!zathura --fork %:r.pdf<CR>

augroup END
