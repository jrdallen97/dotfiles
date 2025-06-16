return {
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
      -- These are vim regexes btw
      pattern = {
        -- Optional colon, require a space
        [[.*<(KEYWORDS):?\s+]],
        -- Optional colon, require a newline
        [[.*<(KEYWORDS):?$]],
      },
      -- Also highlight TODOs outside comments (useful for markdown, for example)
      comments_only = false,
    },
    search = {
      -- Search for keyword followed by colon, whitespace or end-of-line
      pattern = [[\b(KEYWORDS)(:|\s|$)]],
    },
  },
  keys = {
    {
      ']t',
      function()
        -- TODO: it's a shame this doesn't loop
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
}
