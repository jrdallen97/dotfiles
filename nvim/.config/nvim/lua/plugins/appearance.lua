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
      show_icon = vim.g.have_nerd_font,
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

  {
    -- Rainbow delimiters for Neovim with Treesitter
    'HiPhish/rainbow-delimiters.nvim',
    init = function()
      vim.g.rainbow_delimiters = {
        -- Use fewer colors to reduce distraction (inspired by blink.pairs)
        highlight = {
          'RainbowDelimiterOrange',
          'RainbowDelimiterViolet',
          'RainbowDelimiterBlue',
        },
      }
    end,
  },
}
