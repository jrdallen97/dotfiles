-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Turn on line wrapping by default
vim.opt.wrap = true
-- Slightly smarter line wrapping
vim.opt.linebreak = true
-- Keep wrapped lines at the same indentation as the first line
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight all matches when searching
vim.opt.hlsearch = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5
-- Minimal number of screen columns to keep left and right of the cursor.
vim.opt.sidescrolloff = 3

-- Enable treesitter-based code folding by default
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Don't fold anything by default
vim.opt.foldlevelstart = 99
-- Leave the first line of the fold as-is
vim.opt.foldtext = ''

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable slow features when opening big files
-- Most of these seem fine, but I've left them commented out so they're easy to re-enable
vim.cmd [[
function BigFileStuff()
    echo("Big file, disabling slow features")

    " if exists(':TSBufDisable')
    "     exec 'TSBufDisable autotag'
    "     exec 'TSBufDisable highlight'
    "     " etc...
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
