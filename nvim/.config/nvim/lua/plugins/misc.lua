return {
  -- Improvements to netrw. Press `I` to toggle the help back on!
  -- 'tpope/vim-vinegar',

  {
    -- Automatic indentation style detection for Neovim
    'nmac427/guess-indent.nvim',
    opts = {
      filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
        'netrw',
        'tutor',
        'go',
      },
    },
  },

  -- Undo closing a split with `<C-w>u`
  'AndrewRadev/undoquit.vim',
}
