require('lazydev').setup()

-- Load my custom snippets (defined in `~/.config/nvim/snippets`)
require('luasnip.loaders.from_snipmate').lazy_load()
-- Load friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load {
  -- Skip languages that I have custom snippets for
  exclude = { 'go' },
}

-- Set up copilot if work_profile is enabled.
if vim.g.work_profile then
  require('copilot').setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
  }
  ---@diagnostic disable-next-line: missing-fields
  require('blink-copilot').setup {
    max_completions = 1,
    max_attempts = 2,
  }
end

---@module 'blink.cmp'
---@type blink.cmp.Config
require('blink.cmp').setup {
  enabled = function()
    return not vim.tbl_contains({ 'grug-far' }, vim.bo.filetype)
  end,

  keymap = {
    -- <Tab> to accept suggestions
    -- <C-n>/<C-p> or <Up>/<Down> to select items
    -- <C-e> to hide completion menu
    --
    -- See :h blink-cmp-config-keymap for possible commands
    preset = 'super-tab',

    -- Unbind <Tab> for snippets since it's easy to hit accidentally
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<S-Tab>'] = { 'fallback' },

    -- Add some bindings for snippets
    ['<C-l>'] = { 'snippet_forward', 'fallback' },
    ['<C-h>'] = { 'snippet_backward', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'normal',
  },

  completion = {
    -- Automatically show documentation
    documentation = { auto_show = true, auto_show_delay_ms = 500 },

    menu = {
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label', 'label_description', gap = 1 },
          { 'kind' },
        },
      },
    },

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
    default = vim.list_extend(
      { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      vim.g.work_profile and { 'copilot' } or {}
    ),
    providers = {
      lsp = { score_offset = 2 },
      path = { score_offset = 10 },
      snippets = { score_offset = 0, max_items = 5 },
      buffer = { score_offset = -5 },
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- Make lazydev completions top priority
        score_offset = 100,
      },
      copilot = {
        name = 'copilot',
        module = 'blink-copilot',
        enabled = function()
          return vim.g.work_profile
            and vim.g.disable_autosuggestions ~= true
            and vim.b.disable_autosuggestions ~= true
        end,
        score_offset = 100,
        async = true,
      },
    },
  },

  snippets = { preset = 'luasnip' },

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- See :h blink-cmp-config-fuzzy for more information
  fuzzy = {
    implementation = 'prefer_rust_with_warning',
    -- Disable typo resistance to reduce spam
    max_typos = 0,
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },

  -- Command-line mode doesn't work well with super-tab keybinds
  cmdline = { enabled = false },
}
