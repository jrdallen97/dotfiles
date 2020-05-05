let mapleader=','

set number
set mouse=a
set background=dark

" ========== Appearance ==========
" Set non-yellow line numbers (bc they're ugly)
hi LineNr ctermfg=242
" Make non-active splits' status line less visible
hi StatusLineNC ctermfg=247
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

" Improvements to built-in file browser (netrw)
Plug 'tpope/vim-vinegar'

" Shows what you just yanked
Plug 'machakann/vim-highlightedyank'

" Use locally-installed fzf version
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Colourschemes
"Plug 'patstockwell/vim-monokai-tasty'
"Plug 'Reewr/vim-monokai-phoenix'
"Plug 'crusoexia/vim-monokai'

call plug#end()
" ========== End vim-plug section ==========

" ========== Custom keybinds ==========
" Run current file (using shebang)
nmap <Leader>r :w<cr>:!%:p<cr>
nmap <Leader>ff :Files<cr>
nmap <Leader>fs :Rg<cr>
