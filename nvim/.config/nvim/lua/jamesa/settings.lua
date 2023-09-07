-- Basic stuff
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.number = true -- Show line numbers
--vim.opt.relativenumber = true -- Relative line numbers
vim.opt.spell = false -- Disable spellcheck

-- Appearance
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes' -- Always show the signcolumn (prevents it from appearing randomly)
vim.opt.termguicolors = true -- Enables 24-bit RGB color
vim.opt.cursorline = true -- Different bg colour on the line the cursor is on

-- Default tab settings (as-per :help tabstop)
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Scrolling
vim.opt.scrolloff = 3 -- Keep the cursor 3 lines from top/bottom while scrolling
vim.opt.sidescrolloff = 2 -- Keep the cursor 2 lines from left/right while scrolling

-- Wrapping
vim.opt.wrap = true -- Turn on line wrapping
vim.opt.linebreak = true -- Slightly smarter line wrapping

-- Search settings
vim.opt.incsearch = true -- Search as you type
vim.opt.hlsearch = false -- Don't highlight search
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase  = true -- ... unless search term includes caps

-- Set custom listchars (for `set list`)
vim.opt.listchars = {
  tab = '> ',
  space = '·',
  eol = '↵',
  nbsp = '+',
  extends = '>',
  precedes = '<',
}
