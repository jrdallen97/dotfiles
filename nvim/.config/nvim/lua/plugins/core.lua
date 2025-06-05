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

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
      keywords = {
        TIL = {
          icon = '🧠',
          color = '#47d66b',
          alt = { 'VIM' },
        },
      },
      highlight = {
        -- Don't highlight the characters either side of the keyword
        keyword = 'bg',
        -- Don't require a colon after keyword, but do require at least one space
        pattern = [[.*<(KEYWORDS):?\s]],
        -- Also highlight TODOs outside comments (useful for markdown, for example)
        comments_only = false,
      },
      search = {
        -- Also remove the colon here
        pattern = [[\b(KEYWORDS):?\s+]],
      },
    },
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next [T]odo comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous [T]odo comment',
      },
    },
  },
}
