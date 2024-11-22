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

local js = function(bufnr)
  return { 'eslint_d', first(bufnr, 'prettierd', 'prettier') }
end

-- Add a command to globally enable/disable autoformatting
vim.api.nvim_create_user_command('FormatToggle', function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    print 'Auto-format enabled'
  else
    vim.g.disable_autoformat = true
    print 'Auto-format disabled'
  end
end, { desc = 'Toggle autoformat-on-save' })
-- Also add a keymap to do it more easily!
vim.keymap.set('n', '<leader>tf', ':FormatToggle<cr>', { desc = '[T]oggle [F]ormat' })

return {
  {
    -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
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

        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a stop_after_first to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
