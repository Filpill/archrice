set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set cursorline
set expandtab ts=4 sw=4 ai

"Latex Commands
let mapleader = ","
map <leader>p :!zathura --fork %:t:r.pdf<CR><CR>
map <leader>c :!pdflatex %:p<CR>
