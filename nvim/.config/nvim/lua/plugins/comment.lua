local cursor

return {
  {
    -- Smart and powerful comment plugin for neovim
    'numToStr/Comment.nvim',
    lazy = false,
    dependencies = {
      -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = function()
      -- Use dynamic commentstring for better embedded language support in jsx & tsx
      local pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()

      return {
        pre_hook = function(ctx)
          -- Save cursor pos before modifying the line - otherwise we may accidentally move it twice if it was near the end of the line.
          cursor = vim.api.nvim_win_get_cursor(0)

          return pre_hook(ctx)
        end,

        post_hook = function(ctx)
          -- Find the length of the prefix part of the commentstring
          local offset = string.find(vim.bo.commentstring, '%s') * (ctx.cmode == 1 and 1 or -1)

          -- Move cursor forwards/backward by prefix_length depending on if we're commenting/uncommenting
          cursor[2] = cursor[2] + offset
          vim.api.nvim_win_set_cursor(0, cursor)
        end,
      }
    end,
    keys = {
      {
        '<C-/>',
        function()
          require('Comment.api').toggle.linewise.current()
        end,
        mode = { 'n', 'i' },
        desc = 'Toggle comment',
      },
    },
  },

  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup {
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
          -- Only highlight the line containing the keyword
          multiline = false,
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
      }

      local config = require 'todo-comments.config'
      local highlight = require 'todo-comments.highlight'
      local util = require 'todo-comments.util'

      -- Rewrite the entire jump function to add wrapping on end of file
      ---@param up boolean
      local function jump(up, opts)
        opts = opts or {}
        opts.keywords = opts.keywords or {}

        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_get_current_buf()

        local pos = vim.api.nvim_win_get_cursor(win)
        local line_count = vim.api.nvim_buf_line_count(buf)

        local from = up and pos[1] - 1 or pos[1] + 1
        local to = up and 1 or line_count
        if opts.continue then
          from = up and line_count or 1
          to = pos[1]
        end

        for l = from, to, up and -1 or 1 do
          local line = vim.api.nvim_buf_get_lines(buf, l - 1, l, false)[1] or ''
          local ok, start, _, kw = pcall(highlight.match, line)

          if ok and start then
            if config.options.highlight.comments_only and highlight.is_comment(buf, l - 1, start) == false then
              kw = nil
            end
          end

          if kw and #opts.keywords > 0 and not vim.tbl_contains(opts.keywords, kw) then
            kw = nil
          end

          if kw then
            vim.api.nvim_win_set_cursor(win, { l, start - 1 })
            return
          end
        end

        if opts.continue then
          -- If we get this far after continuing, emit a warning
          util.warn 'No todo comments in file'
        else
          -- Otherwise, try again from the start/end of the file
          opts.continue = true
          jump(up, opts)
        end
      end

      vim.keymap.set('n', ']t', function()
        jump(false)
      end, { desc = 'Next [T]odo comment' })
      vim.keymap.set('n', '[t', function()
        jump(true)
      end, { desc = 'Previous [T]odo comment' })
    end,
  },
}
