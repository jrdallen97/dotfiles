" ========== Basic stuff ==========
let mapleader=','
set number
set mouse=a
set background=dark

" ========== Start vim-plug section ==========
" Set up paths
let autoload_path = '~/.config/nvim/autoload/'
let plugged_path = '~/.config/nvim/plugged'

" Auto-download vim-plug if not installed
if empty(glob(autoload_path . 'plug.vim'))
  execute 'silent !curl -fLo ' . autoload_path . 'plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start installing plugins
call plug#begin(plugged_path)

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'ianks/vim-tsx'
Plug 'zah/nim.vim'
if has('macunix')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
endif

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
" Add space & eol to listchars
set listchars+=tab:>-,space:·,eol:¬
" Word wrap & only wrap between words
set wrap
set linebreak

" ========== Colourscheme ==========
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set cursorline

" ========== Custom keybinds ==========
" Fix Y's weird default behaviour
nnoremap Y y$
" Run current file (using shebang)
nmap <leader>rr :w<cr>:!%:p<cr>
nmap <leader>rg :w<cr>:!go run %:p<cr>
" FZF bindings
nmap <leader>ff :Files<cr>
nmap <leader>fs :Rg<cr>
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
