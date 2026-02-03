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
    -- A super powerful autopair plugin for Neovim that supports multiple characters
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
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
