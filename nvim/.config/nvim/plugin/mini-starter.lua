-- Fast and flexible start screen
local starter = require 'mini.starter'
starter.setup {
  header = '',
  items = {
    starter.sections.sessions(5, true),
    starter.sections.recent_files(10, true),
    starter.sections.builtin_actions(),
  },

  -- Remove `-` so I can easily get into Oil
  query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.',
}

-- Add cmd to easily get back to the start screen
vim.api.nvim_create_user_command('Start', function()
  starter.open()
end, { desc = 'Open start screen' })

-- Let BufJump handle these instead of Mini Starter's item navigation.
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniStarterOpened',
  callback = function()
    vim.keymap.del('n', '<C-p>', { buffer = true })
    vim.keymap.del('n', '<C-n>', { buffer = true })
  end,
})
