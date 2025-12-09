return {
  {
    -- Automatic indentation style detection for Neovim
    'nmac427/guess-indent.nvim',
    opts = {
      filetype_exclude = {
        'netrw',
        'tutor',
        'go',
      },
    },
  },

  {
    'm4xshen/autoclose.nvim',
    opts = {
      options = {
        -- Disable when cursor is immediately before an alphanumeric character or opening bracket
        disable_when_touch = true,
      },
      keys = {
        -- Disable for quotes (more annoying than helpful)
        ["'"] = {},
        ['"'] = {},
      },
    },
  },

  {
    -- A simplistic vim plugin to close pairs when a keybind is pressed
    'dhruvasagar/vim-pairify',
    init = function()
      vim.g.pairify_map = '<M-p>'
    end,
  },

  -- Undo closing a split with `<C-w>u`
  'AndrewRadev/undoquit.vim',

  {
    -- Jump to previous and next buffer of the jumplist
    'kwkarlwang/bufjump.nvim',
    opts = {
      -- Jump to the previous/next jump in another file, skipping any jumps within the current file
      backward_key = '<C-p>',
      forward_key = '<C-n>',
    },
  },
}
