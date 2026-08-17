local markdown_types = { 'markdown', 'markdown.mdx', 'text', 'tex', 'plaintex', 'norg' }
local markdown_augroup = vim.api.nvim_create_augroup('markdown-keybinds', { clear = true })

-- Generate and update markdown table of contents
require('mtoc').setup {
  -- Disabling auto-update doesn't work, so instead use an event/pattern that will never be triggered
  auto_update = {
    events = { 'User' },
    pattern = 'MtocAutoUpdateDisabled',
  },
  toc_list = {
    markers = '-',
    indent_size = 4,
    item_format_string = '${indent}${marker} [[#${name}]]',
  },
}

-- A simple and useful set of toggle commands for Markdown
local mt = require 'markdown-toggle'
---@diagnostic disable-next-line: missing-fields
mt.setup {
  -- Extend to include some non-markdown filetypes
  filetypes = markdown_types,
  -- Configure possible checkbox states
  box_table = { 'x' },
  -- Use the above table when cycling/toggling checkboxes
  cycle_box_table = true,
  -- When cycling checkboxes, also include "no checkbox" as the first option
  list_before_box = true,
}

-- Automatic list continuation and formatting
require('autolist').setup()

local function map(mode, keys, func, desc, expr)
  vim.keymap.set(mode, keys, func, {
    expr = expr, -- Required for dot-repeat bindings to work
    buffer = 0,
    desc = desc,
  })
end

-- Create keybinds in an autocmd so they're properly attached to all buffers
vim.api.nvim_create_autocmd('FileType', {
  desc = 'markdown-toggle.nvim keymaps',
  pattern = markdown_types,
  group = markdown_augroup,
  callback = function()
    -- markdown-toggle:
    -- stylua: ignore
    do
      -- Autolist
      map("n", "O",    mt.autolist_up,   'New bullet above')
      map("n", "o",    mt.autolist_down, 'New bullet below')
      map("i", "<CR>", mt.autolist_cr,   'New bullet below')

      -- NORMAL
      map('n', '<M-x>', mt.checkbox_dot, 'Toggle checkbox',       true)
      map('n', '<M-u>', mt.list_dot,     'Toggle unordered list', true)
      map('n', '<M-o>', mt.olist_dot,    'Toggle ordered list',   true)
      map('n', '<M-q>', mt.quote_dot,    'Toggle quote',          true)
      map('n', '<M-h>', mt.heading_dot,  'Toggle heading',        true)

      -- VISUAL
      map('x', '<M-x>', mt.checkbox, 'Toggle checkbox')
      map('x', '<M-u>', mt.list,     'Toggle unordered list')
      map('x', '<M-o>', mt.olist,    'Toggle ordered list')
      map('x', '<M-q>', mt.quote,    'Toggle quote')
      map('x', '<M-h>', mt.heading,  'Toggle heading')
    end

    -- autolist:
    do
      -- Toggle checkbox w/ enter
      map('n', '<CR>', '<cmd>AutolistToggleCheckbox<cr><cr>', 'Toggle checkbox')
      -- Manually recalculate list numbering
      map('n', '<M-r>', '<cmd>AutolistRecalculate<cr>', 'Recalculate list')
    end
  end,
})
