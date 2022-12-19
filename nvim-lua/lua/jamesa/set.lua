-- Basic stuff
vim.opt.mouse = 'a'
vim.opt.background = 'dark'
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab settings (as-per :help tabstop)
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Keep the cursor 3 lines from top/bottom while scrolling
vim.opt.scrolloff = 3

vim.opt.incsearch = true -- Search as you type
vim.opt.hlsearch = false -- Don't highlight search

vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase  = true -- ... unless search term includes caps

-- Add space & eol to listchars
--vim.opt.listchars+='tab:>-,space:·,eol:¬'

-- Turn off line wrapping
vim.opt.wrap = false

-- Always show the signcolumn
vim.opt.signcolumn = 'yes'

-- Appearance
vim.opt.termguicolors = true -- Enables 24-bit RGB color
vim.opt.cursorline = true
