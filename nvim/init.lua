-- ========== Basic stuff ==========
vim.g.mapleader = ','
vim.o.mouse = 'a'
vim.o.number = true
vim.o.background = 'dark'

-- ========== Shorthands to vim functions ==========
local execute = vim.api.nvim_command
local fn = vim.fn

-- ========== Start packer section ==========
-- Ensure packer is installed, and install it if not
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Install plugins with packer
require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

  -- Plugins
  use 'tpope/vim-vinegar'
  use 'tpope/vim-surround'
  use 'airblade/vim-gitgutter'
  use 'machakann/vim-highlightedyank'
  use '~/.fzf'
  use 'junegunn/fzf.vim'
  use 'ntpeters/vim-better-whitespace'

  -- Colourscheme
  use 'morhetz/gruvbox'

  -- Languages
  use 'ianks/vim-tsx'
  use 'cespare/vim-toml'
  if fn.executable('nim') then
    use {'zah/nim.vim', ft = 'nim'}
  end
  if fn.executable('go') then
    use {'fatih/vim-go', ft = 'go', run = ':GoUpdateBinaries'}
  end
end)
-- ========== End packer section ==========

-- ========== Some personal preferences ==========
-- Keep the cursor 3 lines from top/bottom while scrolling
vim.o.scrolloff = 3
-- Search as you type
vim.o.incsearch = true
-- Ignore case when searching, unless search term includes caps
vim.o.ignorecase = true
vim.o.smartcase = true
-- Tab settings (as-per :help tabstop)
vim.o.tabstop = 8
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = false
-- Add space & eol to listchars
vim.o.listchars = 'trail:-,nbsp:+,tab:>-,space:·,eol:¬'
-- Turn on line wrapping & only wrap between words
vim.o.wrap = true
vim.o.linebreak = true
-- Always show the signcolumn
vim.o.signcolumn = 'yes'

-- ========== Colourscheme ==========
vim.o.termguicolors = true
vim.g.gruvbox_italic=1
vim.g.gruvbox_contrast_dark='hard'
vim.cmd("colorscheme gruvbox")
vim.o.cursorline = true
-- Set trailing whitespace colour (from vim-better-whitespace)
vim.cmd("hi ExtraWhitespace guibg=#990000 ctermbg=red")

-- ========== Custom keybinds ==========
-- Fix Y's weird default behaviour
-- vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})
-- Run current file (using shebang)
-- vim.api.nvim_set_keymap('n', '<leader>rr', ':w<cr>:!%:p<cr>', {})
vim.cmd([[
" Fix Y's weird default behaviour
nnoremap Y y$
" Run current file (using shebang)
nmap <leader>rr :w<cr>:!%:p<cr>
nmap <leader>rt :w<cr>:!time %:p<cr>
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
]])
--[[


-- ========== Misc ==========
-- Re-enable netrw_banner (disabled by vinegar)
-- See https://github.com/neovim/neovim/issues/11405
let g:netrw_banner=1
-- Auto-source init.vim when changed
augroup AutoSource
  autocmd! bufwritepost $MYVIMRC source $MYVIMRC
augroup end

--]]
