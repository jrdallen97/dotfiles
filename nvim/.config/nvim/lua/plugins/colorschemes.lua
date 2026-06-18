return {
  {
    -- Soothing pastel colourscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
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
    },
  },
}
