return {
  {
    -- Soothing pastel colourscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato',
        integrations = {
          blink_cmp = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    -- A fancy statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        always_show_tabline = false,
        refresh = {
          -- Increase winbar refresh rate to reduce pop-in
          winbar = 10,
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              -- Truncate to only show first letter
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', 'searchcount', 'selectioncount' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_c = {},
      },
      winbar = {
        lualine_a = {
          { 'filename', path = 1, newfile_status = true, shorting_target = 10 },
        },
      },
      inactive_winbar = {
        lualine_b = {
          { 'filename', path = 1, newfile_status = true, shorting_target = 10 },
        },
      },
    },
  },

  {
    -- A simple statusline with icons
    'crispgm/nvim-tabline',
    opts = {
      show_index = true,
      show_icon = true,
      brackets = { '', '' },
    },
  },

  {
    -- Vimade let's you dim, fade, tint, animate, and customize colors in your windows and buffers
    -- (I mainly use it for dimming inactive splits)
    'tadaa/vimade',
    opts = {
      -- Don't dim the entire window
      fadelevel = 1,
      tint = {
        -- Dim just the background by 10%
        bg = { rgb = { 0, 0, 0 }, intensity = 0.15 },
      },
    },
  },

  {
    -- Indent guides for Neovim
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    opts = {
      scope = {
        enabled = false,
      },
    },
  },
}
