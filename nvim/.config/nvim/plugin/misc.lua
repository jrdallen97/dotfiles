-- Automatic indentation style detection for Neovim
require('guess-indent').setup {
  filetype_exclude = {
    'netrw',
    'tutor',
    'go',
  },
}

-- A super powerful autopair plugin for Neovim that supports multiple characters
require('nvim-autopairs').setup()

-- A simplistic vim plugin to close pairs when a keybind is pressed
vim.g.pairify_map = '<M-p>'

-- Jump to previous and next buffer of the jumplist
require('bufjump').setup {
  -- Jump to the previous/next jump in another file, skipping any jumps within the current file
  backward_key = '<C-p>',
  forward_key = '<C-n>',
}

-- A comfortable CSV/TSV editing plugin for Neovim
require('csvview').setup {
  view = {
    -- Replace delimiters with a border character
    display_mode = 'border',
  },
}
-- stylua: ignore
require('snacks.toggle').new({
  name = 'csvview',
  get = function() return vim.b.csvview_info ~= nil end,
  set = function() vim.cmd 'CsvViewToggle'      end,
}):map '<leader>tv'
