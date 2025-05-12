-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Turn on line wrapping by default
vim.o.wrap = true
-- Slightly smarter line wrapping
vim.o.linebreak = true
-- Keep wrapped lines at the same indentation as the first line
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight all matches when searching
vim.o.hlsearch = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
-- Notice listchars is set using `vim.opt` instead of `vim.o`.
-- It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--  See `:help lua-options`
--  and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5
-- Minimal number of screen columns to keep left and right of the cursor.
vim.o.sidescrolloff = 5

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Enable treesitter-based code folding by default
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Don't fold anything by default
vim.o.foldlevelstart = 99
-- Leave the first line of the fold as-is
vim.o.foldtext = ''

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Disable slow features when opening big files
-- Most of these seem fine, but I've left them commented out so they're easy to re-enable
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
