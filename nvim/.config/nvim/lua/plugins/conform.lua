-- Helper to allow stop_after_first behaviour for a subset of formatters
---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require 'conform'
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

-- Shorthand for which formatters to use for all JS files
local js = function(bufnr)
  return { 'eslint_d', first(bufnr, 'prettierd', 'prettier') }
end

-- Helper to more easily toggle autoformat
---@param v boolean
---@param scope string
local function toggleFormat(v, scope)
  print('Auto-format ' .. (v and 'enabled' or 'disabled') .. ' (' .. scope .. ')')
  return not v
end

-- Add a command to globally enable/disable autoformatting
vim.api.nvim_create_user_command('ToggleFormatGlobal', function()
  vim.g.disable_autoformat = toggleFormat(vim.g.disable_autoformat, 'global')
end, { desc = 'Toggle autoformat-on-save (global)' })

-- And another for doing it per-buffer
vim.api.nvim_create_user_command('ToggleFormat', function()
  vim.b.disable_autoformat = toggleFormat(vim.b.disable_autoformat, 'buffer')
end, { desc = 'Toggle autoformat-on-save (buffer)' })

-- Also add a keymap to do it more easily!
vim.keymap.set('n', '<leader>tf', ':ToggleFormat<cr>', { desc = '[T]oggle Auto[F]ormat (buffer)' })

return {
  -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    -- Use format_after_save rather than format_on_save to make it async!
    format_after_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable "format_after_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 5000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },

      javascript = js,
      javascriptreact = js,
      typescript = js,
      typescriptreact = js,

      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
