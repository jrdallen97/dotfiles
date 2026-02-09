-- Command to manually trigger formatting
vim.api.nvim_create_user_command('Format', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })

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
local function js(bufnr)
  return { 'eslint_d', first(bufnr, 'prettierd', 'prettier') }
end

return {
  -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    { '<leader>F', '<cmd>Format<cr>', desc = 'Format buffer' },
  },
  opts = {
    notify_on_error = false,

    -- Use format_after_save rather than format_on_save to make it async!
    format_after_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        timeout_ms = 5000,
        lsp_format = 'fallback',
      }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },

      javascript = js,
      javascriptreact = js,
      typescript = js,
      typescriptreact = js,
      json = { 'fixjson' },

      go = { 'gofmt', 'goimports' },

      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
