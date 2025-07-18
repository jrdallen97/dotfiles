-- Get or set options (`:h vim.o`)
local o = vim.o
-- Like `vim.o` but with a special interface for interacting with lists & maps (`:h vim.opt`)
-- See `:h lua-options` and `:h lua-options-guide`
local opt = vim.opt

-- NOTE: For more options, see `:help option-list`

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

-- stylua: ignore end

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank { timeout = 250 }
  end,
})

-- Automatically disable cursorcolumn for non-active buffers
local g = vim.api.nvim_create_augroup('hide-cursorcolumn', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  desc = 'Enable cursorcolumn on entering a buffer',
  group = g,
  callback = function()
    o.cursorcolumn = true
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  desc = 'Disable cursorcolumn on leaving a buffer',
  group = g,
  callback = function()
    o.cursorcolumn = false
  end,
})

-- Disable slow features when opening big files
-- Most of these seem unnecessary, but I've left them commented out so they're easy to re-enable
vim.cmd [[
  function BigFileStuff()
    echo("Big file, disabling slow features")

    " if exists(':TSBufDisable')
    "   exec 'TSBufDisable autotag'
    "   exec 'TSBufDisable highlight'
    "   " etc...
    " endif

    setlocal foldmethod=manual
    " syntax off
    " filetype off
    " setlocal noundofile
    " setlocal noswapfile
    " setlocal noloadplugins
  endfunction

  augroup BigFileDisable
    autocmd!
    " Run for files bigger than 10MB
    autocmd BufWinEnter * if getfsize(expand("%")) > 10 * 1024 * 1024 | exec BigFileStuff() | endif
  augroup END
]]
