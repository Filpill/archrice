filetype on
filetype plugin on
filetype indent on
set number
set nocompatible
set expandtab ts=4 sw=4 ai
"set clipboard+=unamedplus

"Syntax and Spell Check Highlight
syntax on
set spell
hi clear SpellBad
hi SpellBad cterm=underline

"Prevent Autocomment Newlines
autocmd FileType * setlocal formatoptions-=cro

"Latex Commands
let mapleader = ","
map <leader>p :!zathura --fork %:t:r.pdf<CR><CR>
map <leader>c :!pdflatex %:p<CR>

"Copy paste to X11 Clipboard
vmap <leader><F6> :!xclip -f -sel clip<CR>
map  <leader><F7> mz:-1r !xclip -o -sel clip<CR>
