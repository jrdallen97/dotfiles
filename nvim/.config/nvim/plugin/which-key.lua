-- Show available keybindings in a popup as you type
require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  -- This setting is independent of vim.o.timeoutlen
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },

  -- Document existing key chains
  spec = {
    { '<leader>a', group = 'Sidekick' },
    { '<leader>c', group = 'Quickfix' },
    { '<leader>d', group = 'Diagnostics' },
    { '<leader>e', group = 'Edit' },
    { '<leader>g', group = 'Git' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>r', group = 'Run' },
    { '<leader>R', group = 'Test' },

    -- Snacks.picker
    { '<leader>f', group = 'Find' },
    { '<leader>s', group = 'Search' },
    { '<leader>h', group = 'Help' },

    -- Other
    { 'gh', group = 'Git Hunk' },
  },
}

vim.keymap.set('n', '<leader>?', function()
  require('which-key').show { global = false }
end, { desc = 'Buffer Local Keymaps (which-key)' })
