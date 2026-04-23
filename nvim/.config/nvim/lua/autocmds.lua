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
vim.api.nvim_create_autocmd('VimResized', { command = 'wincmd =' })

-- Reset cmdheight on switching tabs (I'm not sure why it grows sometimes)
vim.api.nvim_create_autocmd('TabEnter', { command = 'set cmdheight=1' })

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
    -- Don't disable cursorline in diff mode
    if not vim.wo.diff then
      vim.o.cursorline = false
    end
  end,
})

-- Dynamically update settings based on filetype.
-- Useful for window-level settings that otherwise wouldn't be reset when switching buffers, e.g. signcolumn.
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('default-settings', { clear = true }),
  callback = function()
    if vim.tbl_contains({ 'markdown' }, vim.bo.filetype) then
      -- Only show sign column when there's something to show
      vim.wo.signcolumn = 'auto'
    else
      -- Always show sign column (otherwise it will shift text)
      vim.wo.signcolumn = 'yes'
    end
  end,
})

-- Automatically run :Big and :Huge for files exceeding certain sizes
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('bigfile', { clear = true }),
  callback = function(ev)
    vim.api.nvim_buf_call(ev.buf, function()
      local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(ev.buf))
      if size <= vim.g.bigfile_size then
        return
      end
      local huge = size > vim.g.hugefile_size

      if huge then
        -- :Huge doesn't work properly unless treesitter has already loaded
        vim.defer_fn(function()
          vim.cmd 'Huge'
        end, 50)
      else
        vim.cmd 'Big'
      end

      vim.print((huge and 'Huge' or 'Big') .. ' file, disabling slow features')
    end)
  end,
})
