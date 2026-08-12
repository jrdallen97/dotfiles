local map = vim.keymap.set

-- Comment/uncomment lines
require('mini.comment').setup {
  mappings = {
    -- Use custom logic below to preserve cursor position
    comment_line = '',
    textobject = 'ic',
  },
}
local toggle_comment = function()
  -- Save original cursor position
  local pos = vim.api.nvim_win_get_cursor(0)
  -- Find the length of the comment prefix
  local ref = { pos[1], pos[2] + 1 }
  local offset = MiniComment.get_commentstring(ref):find '%s' or 0
  -- Save the line length so we can work out if we added or removed a comment
  local before = #vim.api.nvim_get_current_line()

  MiniComment.toggle_lines(pos[1], pos[1], { ref_position = ref })

  -- Check the new line length and offset the cursor position appropriately
  local after = #vim.api.nvim_get_current_line()
  pos[2] = math.max(pos[2] + offset * (before < after and 1 or -1), 0)
  vim.api.nvim_win_set_cursor(0, pos)
end
map('n', 'gcc', toggle_comment, { desc = 'Toggle comment line' })
map({ 'n', 'i' }, '<C-/>', toggle_comment, { desc = 'Toggle comment' })
