local map = vim.keymap.set

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- Highlight and trim trailing whitespace
require('mini.trailspace').setup()
-- Add a command to easily trim whitespace
vim.api.nvim_create_user_command('TrimWhitespace', MiniTrailspace.trim, {
  desc = 'Trim whitespace',
})

-- Split and join arguments
require('mini.splitjoin').setup()

-- Move any selection in any direction
require('mini.move').setup {
  -- stylua: ignore
  mappings = {
    -- Move visual selection
    left =  '<M-Left>',
    right = '<M-Right>',
    up =    '<M-Up>',
    down =  '<M-Down>',
  },
}
-- Also add normal/insert mode bindings
-- stylua: ignore
do
  local move = MiniMove.move_line
  map({'n', 'i'}, '<M-Left>',  function() move 'left'  end, { desc = 'Move current line left' })
  map({'n', 'i'}, '<M-Right>', function() move 'right' end, { desc = 'Move current line right' })
  map({'n', 'i'}, '<M-Up>',    function() move 'up'    end, { desc = 'Move current line up' })
  map({'n', 'i'}, '<M-Down>',  function() move 'down'  end, { desc = 'Move current line down' })
end

-- Text edit operators (e.g. evaluate text, duplicate text)
require('mini.operators').setup {
  -- Default map conflicts with `gx` (open URL)
  exchange = { prefix = '<leader>x' },
  -- Default map conflicts with `gr` (goto references)
  replace = { prefix = '' },
}

-- Go forward/backward with square brackets
require('mini.bracketed').setup {
  -- Disable the weird ones
  treesitter = { suffix = '' },
  undo = { suffix = '' },
  yank = { suffix = '' },
}
-- Reset `]c` keymap in diff buffers
vim.api.nvim_create_autocmd({ 'OptionSet', 'UIEnter' }, {
  group = 'mini',
  callback = function()
    if vim.wo.diff then
      vim.keymap.set('n', '[c', '[c', { buffer = true, remap = true })
      vim.keymap.set('n', ']c', ']c', { buffer = true, remap = true })
    end
  end,
})

-- Icon provider
require('mini.icons').setup {
  style = vim.g.have_nerd_font and 'glyph' or 'ascii',
}

-- Highlight other occurrences of word under cursor
require('mini.cursorword').setup()
-- Don't highlight the actual word under the cursor
vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', {})

-- Set up terminal background synchronization
-- (prevents black borders if terminal size isn't perfectly aligned)
require('mini.misc').setup_termbg_sync()
