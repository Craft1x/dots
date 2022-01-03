set nocompatible              " be iMproved, required
filetype off                  " required

"syntax highlight
filetype plugin on
set t_Co=256
set cursorline

set showcmd

" Enable Highlight Search
set hlsearch" Highlight while search
set incsearch


" Set true colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Set leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

set laststatus=2
set noshowmode
set number 
set ai
set tabstop=2
set shiftwidth=4
set autoindent
set smartindent
set encoding=utf-8
" set spell

" Yank file to clip
nnoremap <Leader>C gg"+yG
nnoremap <Leader>c "+y

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz


"let g:airline_theme='random'

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
let &t_ut=''

"set background to transparent 
:hi Normal guibg=NONE ctermbg=NONE
