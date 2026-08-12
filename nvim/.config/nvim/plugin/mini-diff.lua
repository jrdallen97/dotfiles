local map = vim.keymap.set

-- Work with diff hunks
require('mini.diff').setup {
  mappings = {
    -- Unbind these & use custom mappings instead
    apply = '',
    reset = '',

    -- More typical textobject
    textobject = 'ih',
  },
  options = {
    -- Wrap around the end of file during hunk navigation
    wrap_goto = true,
  },
}
map('n', '<leader>go', MiniDiff.toggle_overlay, { desc = 'Diff Overlay' })
local diff = function(action, s)
  return function()
    return string.format(s, MiniDiff.operator(action))
  end
end
-- stylua: ignore
do
  map('n', 'ghs', diff('apply', '%sih'      ), { expr = true, remap = true, desc = 'Stage Hunk' })
  map('x', 'ghs', diff('apply', '%s'        ), { expr = true, remap = true, desc = 'Stage Selection' })
  map('n', 'ghS', diff('apply', 'go%sG<C-o>'), { expr = true, remap = true, desc = 'Stage File' })
  map('n', 'ghr', diff('reset', '%sih'      ), { expr = true, remap = true, desc = 'Restore Hunk' })
  map('x', 'ghr', diff('reset', '%s'        ), { expr = true, remap = true, desc = 'Restore Selection' })
  map('n', 'ghR', diff('reset', 'go%sG<C-o>'), { expr = true, remap = true, desc = 'Restore File' })
end
