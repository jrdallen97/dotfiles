local lsp = require('lsp-zero')

lsp.preset('recommended')

-- LSP names come from the `lspconfig` server names, not `mason.nvim` package names
-- See here: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
lsp.ensure_installed({
  'lua_ls',
  'vimls',
  'bashls',
  'gopls',
  'marksman', -- Markdown
  'tsserver',
  'pyright',
})

-- Make sumneko_lua handle neovim lua config properly
lsp.nvim_workspace()

lsp.setup()
