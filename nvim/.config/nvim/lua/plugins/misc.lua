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

  -- Undo closing a split with `<C-w>u`
  'AndrewRadev/undoquit.vim',

  {
    -- Jump to previous and next buffer of the jumplist
    'kwkarlwang/bufjump.nvim',
    opts = {
      -- Jump to the previous/next jump in another file, skipping any jumps within the current file
      backward_key = '<C-p>',
      forward_key = '<C-n>',

      -- Jump to the previous/next jump in the current file, skipping any jumps that are in other files
      backward_same_buf = '<M-o>',
      forward_same_buf = '<M-i>',

      on_success = nil,
    },
  },
}
