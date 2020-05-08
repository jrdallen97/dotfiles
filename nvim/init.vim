" ========== Basic stuff ==========
let mapleader=','
set number
set mouse=a
set background=dark

" ========== Start vim-plug section ==========
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-vinegar'
Plug 'machakann/vim-highlightedyank'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Colourscheme
Plug 'morhetz/gruvbox'

call plug#end()
" ========== End vim-plug section ==========

" ========== Some personal preferences ==========
" Keep the cursor 3 lines from top/bottom while scrolling
set scrolloff=3
" Search as you type
set incsearch
" Ignore case when searching, unless search term includes caps
set ignorecase
set smartcase
" Tab settings (as-per :help tabstop)
set tabstop=8
set softtabstop=2
set shiftwidth=2
set noexpandtab

" ========== Colourscheme ==========
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" ========== Custom keybinds ==========
" Fix Y's weird default behaviour
nnoremap Y y$
" Run current file (using shebang)
nmap <Leader>r :w<cr>:!%:p<cr>
" FZF bindings
nmap <Leader>ff :Files<cr>
nmap <Leader>fs :Rg<cr>
" Easily edit init.vim
nmap <Leader>ev :tabe ~/.config/nvim/init.vim<cr>

" ========== Misc ==========
" Re-enable netrw_banner (disabled by vinegar)
" See https://github.com/neovim/neovim/issues/11405
let g:netrw_banner=1
" Auto-source init.vim when changed
augroup AutoSource
  autocmd! bufwritepost $MYVIMRC source $MYVIMRC
augroup end
