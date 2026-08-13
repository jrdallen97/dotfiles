-- Mason manages external language servers, formatters, and linters.
require('mason').setup {}

-- A simple way to run and visualize code actions with other picker plugins
require('tiny-code-action').setup { picker = 'snacks' }

-- Useful status updates for LSP.
require('fidget').setup {}

-- Configure buffer-local mappings whenever a language server attaches.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local function map(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local picker = require 'snacks.picker'

    local function hover()
      vim.lsp.buf.hover { border = 'solid' }
    end
    local function signature_help()
      vim.lsp.buf.signature_help { border = 'solid' }
    end
    local code_action = require('tiny-code-action').code_action

    -- stylua: ignore
    do
      map('gd', picker.lsp_definitions,       'Goto Definition')
      map('gr', picker.lsp_references,        'Goto References')
      map('gI', picker.lsp_implementations,   'Goto Implementation')
      map('gD', picker.lsp_type_definitions,  'Goto Type Definition')
      map('gO', picker.lsp_symbols,           'Open Document Symbols (Outline)')
      map('gW', picker.lsp_workspace_symbols, 'Open Workspace Symbols')

      map('<F2>', vim.lsp.buf.rename, 'Rename')
      map('<F4>', code_action,        'Code Action', { 'n', 'x' })

      map('K',     hover,          'Hover Documentation')
      map('<C-k>', hover,          'Hover Documentation', { 'n', 'i' })
      map('<C-s>', signature_help, 'Signature Help', { 'n', 'i' })
    end

    -- Only create the inlay hint keymap if the language server supports them
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      require('snacks.toggle').inlay_hints():map '<leader>th'
    end
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = true },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = true,
}

-- Add any additional override configuration in the following table. Available keys are:
-- - cmd (table): Override the default command used to start the server
-- - filetypes (table): Override the default list of associated filetypes for the server
-- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
-- - settings (table): Override the default settings passed when initializing the server.
--   For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
--
-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
---@type table<string, vim.lsp.Config>
local servers = {
  ts_ls = {
    root_dir = function(bufnr, on_dir)
      -- Override lspconfig's "monorepo support" bc it just doesn't work
      local root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' }
      local project_root = vim.fs.root(bufnr, { root_markers })
      return on_dir(project_root)
    end,
  },

  tailwindcss = {
    hovers = true,
    suggestions = true,
    root_dir = function(bufnr, on_dir)
      local root_markers = {
        'tailwind.config.cjs',
        'tailwind.config.js',
        'postcss.config.js',
      }
      local project_root = vim.fs.root(bufnr, { root_markers })
      return on_dir(project_root)
    end,
  },
}

-- The tools listed below will be installed automatically.
-- Use `:Mason` to check the status of installed tools and/or manually install other tools.
local ensure_installed = {
  -- Core
  'lua_ls',
  'stylua',
  'bashls',

  -- Other
  'ruff',
  'basedpyright',
  'fixjson',
  'markdown-oxide',
}
-- Only install these additional tools if work_profile is enabled
if vim.g.work_profile then
  vim.list_extend(ensure_installed, {
    -- Backend
    'gopls',
    'golangci-lint',
    'goimports',
    'protols',

    -- Frontend
    'ts_ls',
    'eslint',
    'eslint_d',
    'prettierd',
    'cssls',
    'tailwindcss',
  })
end
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- Apply any LSP config overrides as defined in the `servers` table above.
for server, config in pairs(servers) do
  if not vim.tbl_isempty(config) then
    vim.lsp.config(server, config)
  end
end

-- Automatically enable all LSP servers that are installed via Mason
require('mason-lspconfig').setup()
