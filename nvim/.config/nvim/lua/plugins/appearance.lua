-- Custom cursor location to also show virtual columns when applicable
-- https://github.com/nvim-lualine/lualine.nvim/issues/1276#issuecomment-2400374924b
local location = function()
  local line = vim.fn.line '.'
  local ccol = vim.fn.charcol '.'
  local vcol = vim.fn.virtcol '.'
  if ccol == vcol then
    return string.format('%3d:%-2d', line, ccol)
  else
    return string.format('%3d:%d:~%-2d', line, ccol, vcol)
  end
end

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

              -- Override cursor column using a colour somewhere between the background & cursor line
              CursorColumn = { bg = '#2c2f45' },
            }
          end,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
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
        lualine_z = { location },
      },
      inactive_sections = {
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { location },
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
    -- A simple tabline with icons
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
