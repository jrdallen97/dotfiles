-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  desc = 'Highlight on yank',
  callback = function()
    vim.hl.on_yank { timeout = 250 }
  end,
})

-- Resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd('VimResized', {
  command = 'wincmd =',
})

-- Syntax highlighting for .env files
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('dotenv_ft', { clear = true }),
  pattern = { '.env', '.env.*' },
  callback = function()
    vim.bo.filetype = 'dosini'
  end,
})

-- Auto-create missing dirs when saving a file
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('auto-create-dir', { clear = true }),
  desc = 'Auto-create missing dirs when saving a file',
  pattern = '*',
  callback = function()
    if vim.o.filetype == 'oil' then
      return
    end
    local dir = vim.fn.expand '<afile>:p:h'
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Automatically disable cursorcolumn for non-active buffers
vim.api.nvim_create_autocmd('WinEnter', {
  group = vim.api.nvim_create_augroup('hide-cursor', { clear = true }),
  desc = 'Enable cursor on entering a buffer',
  callback = function()
    vim.o.cursorcolumn = true
    vim.o.cursorline = true
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = 'hide-cursor',
  desc = 'Disable cursor on leaving a buffer',
  callback = function()
    vim.o.cursorcolumn = false
    vim.o.cursorline = false
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
