" ========== Basic stuff ==========
let mapleader=','
set number
set mouse=a
set background=dark

" ========== Some personal preferences ==========
" Keep the cursor 3 lines from top/bottom while scrolling
set scrolloff=3
" Search as you type
set incsearch
" Ignore case in searches until you use an uppercase letter
set ignorecase
set smartcase
" Tab settings (as-per :help tabstop)
set tabstop=8
set softtabstop=2
set shiftwidth=2
set noexpandtab

" ========== Start vim-plug section ==========
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-vinegar'
Plug 'machakann/vim-highlightedyank'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Colourschemes
Plug 'crusoexia/vim-monokai'
"Plug 'patstockwell/vim-monokai-tasty'
"Plug 'Reewr/vim-monokai-phoenix'

call plug#end()
" ========== End vim-plug section ==========

" ========== Colourscheme ==========
set termguicolors
colorscheme monokai

" ========== Colourscheme tweaks ==========
" Change line number colours
"hi LineNr ctermfg=242 guifg=242
" Change non-active splits' status line colours
"hi StatusLineNC ctermfg=247 guifg=247

" ========== Custom keybinds ==========
" Fix weird default behaviour for Y
nnoremap Y y$
" Run current file (using shebang)
nmap <Leader>r :w<cr>:!%:p<cr>
" FZF bindings
nmap <Leader>ff :Files<cr>
nmap <Leader>fs :Rg<cr>
