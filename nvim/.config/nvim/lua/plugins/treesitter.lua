return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  -- Configure Treesitter. See `:help nvim-treesitter-intro`.
  config = function()
    local treesitter = require 'nvim-treesitter'

    -- Ensure basic parser are installed
    treesitter.install(vim.list_extend({
      'bash',
      'c',
      'diff',
      'go',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    }, vim.g.work_profile and { 'javascript', 'typescript', 'tsx' } or {}))

    local function enable(buf, language)
      -- Load parser if available, otherwise return early
      if not vim.treesitter.language.add(language) then
        return
      end

      -- Enable syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- Enable treesitter based folds (see `:help folds`)
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'

      -- Enable treesitter based indentation if available
      if vim.treesitter.query.get(language, 'indent') ~= nil then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local available_parsers = treesitter.get_available()

    -- Automatically install/load parsers and enable treesitter features
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local language = vim.treesitter.language.get_lang(args.match)
        if not language then
          return
        end

        local installed = vim.tbl_contains(treesitter.get_installed 'parsers', language)

        -- Attempt to install any missing parsers and enable them asynchronously when done
        if not installed and vim.tbl_contains(available_parsers, language) then
          treesitter.install(language):await(function()
            enable(args.buf, language)
          end)
          return
        end

        enable(args.buf, language)
      end,
    })
  end,
}
