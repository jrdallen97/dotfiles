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

" Colourschemes
Plug 'crusoexia/vim-monokai'
"Plug 'patstockwell/vim-monokai-tasty'
"Plug 'Reewr/vim-monokai-phoenix'

call plug#end()
" ========== End vim-plug section ==========

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

" ========== Colourscheme ==========
set termguicolors
colorscheme monokai

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
augroup Reload
  autocmd! bufwritepost $MYVIMRC source $MYVIMRC
augroup end
