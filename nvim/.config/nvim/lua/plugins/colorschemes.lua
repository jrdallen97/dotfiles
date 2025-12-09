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
        macchiato = function()
          return {
            -- Override column colour using the colour for CursorLine
            ColorColumn = { bg = '#303347' },

            -- Override cursor column to match cursor line
            CursorColumn = { bg = '#303347' },
          }
        end,
      },
    },
  },

  {
    -- Warm Green Theme for Neovim and Beyond
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = true,
    },
  },

  {
    -- A highly customizable theme
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        dim_inactive = false,
      },
      groups = {
        all = {
          -- I prefer mini.nvim's default styles (just a simple underline)
          MiniCursorword = {},
        },
        nordfox = {
          -- Plain white so it doesn't clash git changed lines
          CursorLineNr = { fg = '#ffffff' },
        },
      },
    },
  },
}
