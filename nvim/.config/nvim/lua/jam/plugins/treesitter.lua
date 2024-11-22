return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'go',
          'html',
          'javascript',
          'lua',
          'markdown',
          'markdown_inline',
          'tsx',
          'typescript',
          'vim',
          'vimdoc',
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, bufnr)
            -- Disable in large markdown buffers
            -- return lang == 'markdown' and vim.api.nvim_buf_line_count(bufnr) > 50000

            -- Disable in huge buffers
            return vim.api.nvim_buf_line_count(bufnr) > 50000
          end,
        },
        indent = { enable = true },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see :help nvim-treesitter-incremental-selection-mod
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
