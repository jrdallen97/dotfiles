vim.pack.add {
  -- Soothing pastel colourscheme
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
}

require('catppuccin').setup {
  flavour = 'macchiato',
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 0.1,
  },
  integrations = {
    blink_cmp = true,
    fidget = true,
    fzf = true,
    grug_far = true,
    which_key = true,
  },
  highlight_overrides = {
    macchiato = function(colors)
      return {
        -- Override column colour using the colour for CursorLine
        ColorColumn = { bg = '#303347' },

        -- Override cursor column to match cursor line
        CursorColumn = { bg = '#303347' },

        -- Make markdown links look nicer when concealed
        ['@markup.link.label.markdown_inline'] = { fg = colors.blue, underline = true },
      }
    end,
  },
}

vim.cmd.colorscheme(vim.g.dark_scheme)
