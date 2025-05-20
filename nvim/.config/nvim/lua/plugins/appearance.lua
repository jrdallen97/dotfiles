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
        dim_inactive = {
          enabled = true,
        },
        integrations = {
          blink_cmp = true,
          which_key = true,
          fzf = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'hard'
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
          winbar = 1,
        },
        component_separators = { left = '', right = '' },
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
        lualine_c = { 'filename', 'selectioncount', 'searchcount' },
        lualine_x = {
          'filetype',
          'encoding',
          { 'fileformat', padding = { left = 1, right = 2 } },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
      },
      winbar = {
        lualine_c = {
          { 'filename', path = 1, newfile_status = true, shorting_target = 10 },
        },
      },
      inactive_winbar = {
        lualine_c = {
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
      brackets = { ' ', '' },
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
