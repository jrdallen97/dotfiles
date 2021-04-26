" ========== Basic stuff ==========
let mapleader=','
set number
set mouse=a
set background=dark

" ========== Start vim-plug section ==========
" Start installing plugins
call plug#begin('~/.config/nvim/plugged')

" Plugins
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'

" Colourscheme
Plug 'morhetz/gruvbox'

" Misc. languages
Plug 'ianks/vim-tsx'
Plug 'cespare/vim-toml'
if executable('nim')
  Plug 'zah/nim.vim', {'for': 'nim'}
endif

" Go
if executable('go')
  Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoUpdateBinaries'}
endif
" disable vim-go's :GoDef binding (gd) - will be handled by coc.nvim instead
let g:go_def_mapping_enabled = 0

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
" Add space & eol to listchars
set listchars+=tab:>-,space:·,eol:¬
" Turn on line wrapping & only wrap between words
set wrap
set linebreak
" Always show the signcolumn
set signcolumn=yes

" ========== Colourscheme ==========
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set cursorline
" Set trailing whitespace colour (from vim-better-whitespace)
hi ExtraWhitespace guibg=#990000 ctermbg=red

" ========== Custom keybinds ==========
" Fix Y's weird default behaviour
nnoremap Y y$
" Run current file (using shebang)
nmap <leader>rr :w<cr>:!%:p<cr>
nmap <leader>rg :w<cr>:!go run %:p<cr>
" FZF bindings
nmap <leader>ff :Files!<cr>
nmap <leader>fg :GFiles!<cr>
nmap <leader>fs :Rg!<cr>
nmap <leader>fr :History!<cr>
" Easily edit init.vim
nmap <leader>ev :tabe ~/.config/nvim/init.vim<cr>
" Easily toggle showing whitespace
nmap <leader>l :set list!<cr>
" Hide highlighted search results
nmap <leader>/ :noh<cr>

" ========== Misc ==========
" Re-enable netrw_banner (disabled by vinegar)
" See https://github.com/neovim/neovim/issues/11405
let g:netrw_banner=1
" Auto-source init.vim when changed
augroup AutoSource
  autocmd! bufwritepost $MYVIMRC source $MYVIMRC
augroup end
