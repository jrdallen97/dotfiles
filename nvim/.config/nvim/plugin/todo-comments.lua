-- Highlight todo, notes, etc in comments
-- Depends on: `nvim-lua/plenary.nvim`
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
---@param direction 1|-1
local function jump(direction)
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  local line = vim.api.nvim_win_get_cursor(win)[1]
  local line_count = vim.api.nvim_buf_line_count(buf)

  for _ = 1, line_count do
    line = (line - 1 + direction) % line_count + 1
    local text = vim.api.nvim_buf_get_lines(buf, line - 1, line, false)[1] or ''
    local start = highlight.match(text)

    if
      start
      and (
        not config.options.highlight.comments_only
        or highlight.is_comment(buf, line - 1, start) ~= false
      )
    then
      vim.api.nvim_win_set_cursor(win, { line, start - 1 })
      return
    end
  end

  util.warn 'No todo comments in file'
end

vim.keymap.set('n', ']t', function()
  jump(1)
end, { desc = 'Next Todo' })
vim.keymap.set('n', '[t', function()
  jump(-1)
end, { desc = 'Previous Todo' })
