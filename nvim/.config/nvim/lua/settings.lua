-- NOTE: For more options, see `:help option-list`

-- Get or set options (`:h vim.o`)
local o = vim.o
-- Like `vim.o` but with a special interface for interacting with lists & maps (`:h vim.opt`)
-- See `:h lua-options` and `:h lua-guide-options`
local opt = vim.opt

-- stylua: ignore start

-- General
o.undofile   = true -- Enable persistent undo (see also `:h undodir`)
o.mouse      = 'a'  -- Enable mouse for all available modes
o.updatetime = 100  -- Decrease update time
o.timeoutlen = 500  -- Decrease mapped sequence wait time
o.confirm    = true -- Ask whether you want to save when running commands like `:q` or `:e`

-- Appearance
o.number        = true    -- Show line numbers
o.cursorline    = true    -- Highlight current line
o.cursorcolumn  = false   -- Highlight current column (dynamically controlled via autocmd below)
o.showmode      = false   -- Don't show mode in command line
o.signcolumn    = 'yes'   -- Always show sign column (otherwise it will shift text)
o.scrolloff     = 5       -- Number of visible lines to keep above and below the cursor
o.sidescrolloff = 5       -- Number of visible columns to keep left and right of the cursor
o.smoothscroll  = true    -- Make scrolling use screen lines
o.fillchars     = 'eob: ' -- Don't show `~` outside of buffer
o.list          = true    -- Show certain hidden characters
opt.listchars   = {       -- Make hidden characters display nicely
  tab   = '» ',
  trail = '·',
  nbsp  = '␣',
}

-- Wrapping
o.wrap        = true -- Enable line wrapping by default
o.linebreak   = true -- Wrap long lines at 'breakat'
o.breakindent = true -- Indent wrapped lines to match line start

-- Splits
o.splitbelow = true -- Horizontal splits will be below
o.splitright = true -- Vertical splits will be to the right

-- Search/Replace
o.ignorecase  = true    -- Ignore case when searching (unless you include `\C` in search)
o.incsearch   = true    -- Show search results while typing
o.infercase   = true    -- Infer letter cases for a richer built-in keyword completion
o.smartcase   = true    -- Don't ignore case when searching if pattern has upper case
o.smartindent = true    -- Make indenting smart
o.hlsearch    = true    -- Highlight all matches when searching
o.inccommand  = 'split' -- Preview substitutions as you type

-- Folds
o.foldtext       = ''     -- Show the first line of the fold as-is
o.foldlevelstart = 99     -- Don't fold anything by default
o.foldmethod     = 'expr' -- Enable treesitter-based code folding by default
o.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)
