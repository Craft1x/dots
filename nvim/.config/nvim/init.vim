set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.config/nvim/plugged')

" Auto completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki

Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'Yggdroot/indentLine'

Plug 'neovim/nvim-lspconfig'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}

Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'phpactor/ncm2-phpactor'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'




" Theme
Plug 'sonph/onehalf', { 'rtp': 'vim' }
" FZF file searcher
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Js hightlight
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
" 
Plug 'ternjs/tern_for_vim', { 'do' : 'npm install' }
" Colors 
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Initialize plugin system
call plug#end()


lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
EOF

"Plug 'Yggdroot/indentLine'
"syntax highlight
filetype plugin on
syntax on
set omnifunc=syntaxcomplete#Complete
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

set smartcase
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
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set encoding=utf-8

" FZF Keybinds
nnoremap <Leader>f :FZF<cr>

" Binds for Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Yank file to clip
nnoremap <Leader>C gg"+yG
nnoremap <Leader>c "+yy

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

let g:airline_powerline_fonts = 1 "Включить поддержку Powerline шрифтов
let g:airline#extensions#keymap#enabled = 0 "Не показывать текущий маппинг
let g:airline_section_z = "\ue0a1:%l/%L Col:%c" "Кастомная графа положения курсора
let g:Powerline_symbols='unicode' "Поддержка unicode
let g:airline#extensions#xkblayout#enabled = 0 "Про это позже расскажу

let g:airline_theme='onedark'
"let g:airline_theme='random'

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
let &t_ut=''

"set background to transparent 
:hi Normal guibg=NONE ctermbg=NONE


let g:UltiSnipsExpandTrigger="<tab>"
" list all snippets for current filetype
let g:UltiSnipsListSnippets="<c-l>"

set inccommand=nosplit
set mouse=a
set guicursor=


" fixes bug in https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
set colorcolumn=99999

" Replace all alias
nnoremap S :%s//g<Left><Left>

autocmd filetype nroff nnoremap Q :w <bar> silent exec '!groff -ms '.shellescape('%').' -T pdf > '.shellescape('%:r').'.pdf'<CR>
