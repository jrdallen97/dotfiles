return {
  {
    -- Soothing pastel colourscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('catppuccin').setup { flavour = 'macchiato' }
      vim.cmd.colorscheme 'catppuccin'
    end,
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
