---Helper to allow stop_after_first behaviour for a subset of formatters
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

return {
  {
    -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_after_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
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
