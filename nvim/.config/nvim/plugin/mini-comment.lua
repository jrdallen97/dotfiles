local map = vim.keymap.set

local ts_context_commentstring = require 'ts_context_commentstring'
ts_context_commentstring.setup {
  enable_autocmd = false,
}

local function get_commentstring(ref)
  -- ts_context_commentstring doesn't always uncomment JSX-style comments properly, so override that logic
  if
    vim.tbl_contains({ 'javascriptreact', 'typescriptreact' }, vim.bo.filetype)
    and vim.api.nvim_buf_get_lines(0, ref[1] - 1, ref[1], false)[1]:match '^%s*{/%*.*%*/}%s*$'
  then
    return '{/* %s */}'
  end

  return ts_context_commentstring.calculate_commentstring() or vim.bo.commentstring
end

-- Comment/uncomment lines
require('mini.comment').setup {
  options = {
    custom_commentstring = get_commentstring,
  },
  mappings = {
    -- Use custom logic below to preserve cursor position
    comment_line = '',
    textobject = 'ic',
  },
}

-- Preserve relative cursor position when commenting/uncommenting.
-- Accepts a count and works with dot-repeat.
local toggle_comment = function()
  -- Save original cursor position
  local pos = vim.api.nvim_win_get_cursor(0)
  -- Find the length of the comment prefix
  local ref = { pos[1], pos[2] + 1 }
  local offset = get_commentstring(ref):find '%s' or 0
  -- Save the line length so we can work out if we added or removed a comment
  local before = #vim.api.nvim_get_current_line()
  -- Support commenting multiple lines with a count, e.g. `3gcc`
  local end_line = math.min(pos[1] + vim.v.count1 - 1, vim.api.nvim_buf_line_count(0))

  MiniComment.toggle_lines(pos[1], end_line, { ref_position = ref })

  -- Check the new line length and offset the cursor position appropriately
  local after = #vim.api.nvim_get_current_line()
  pos[2] = math.max(pos[2] + offset * (before < after and 1 or -1), 0)
  vim.api.nvim_win_set_cursor(0, pos)

  -- Use `tpope/vim-repeat` to enable dot-repeat
  vim.fn['repeat#set']('gcc', vim.v.count)
end
map('n', 'gcc', toggle_comment, { desc = 'Toggle comment line' })
map({ 'n', 'i' }, '<C-/>', toggle_comment, { desc = 'Toggle comment' })
