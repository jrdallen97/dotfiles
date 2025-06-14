return {
  -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        'rafamadriz/friendly-snippets',
      },
      opts = {},
      config = function()
        -- Enable js snippets in ts/react
        require('luasnip').filetype_extend('javascript', {
          'javascriptreact',
          'typescript',
          'typescriptreact',
        })

        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'super-tab',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = true, auto_show_delay_ms = 0 },

      list = {
        selection = {
          -- Automatically highlight the first suggestion
          preselect = true,
          -- Don't automatically insert suggestions and you scroll the list
          auto_insert = false,
        },
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lsp = { score_offset = 2 },
        path = { score_offset = 10 },
        snippets = { score_offset = 0 },
        buffer = { score_offset = -5 },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- Make lazydev completions top priority
          score_offset = 100,
        },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      -- Disable typo resistance to reduce spam
      max_typos = function()
        return 0
      end,
      sorts = {
        -- Deprioritise emmet suggestions bc they're really annoying!
        function(a, b)
          if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
            return
          end
          return b.client_name == 'emmet_language_server'
        end,
        'exact',
        'score',
        'sort_text',
      },
    },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },

    -- Command-line mode feels kinda buggy atm
    cmdline = { enabled = false },
  },
}
