-- Get just the name of the current file (excluding path & extension)
local function get_file_name()
  local file = vim.fn.expand '%'
  local file_name = file:match '[^/]*.md$'
  return file_name:sub(0, #file_name - 3)
end

return {
  {
    -- Generate and auto-update table of contents list for markdown
    'hedyhli/markdown-toc.nvim',
    cmd = { 'Mtoc' }, -- Lazy load on "Mtoc" command
    opts = {
      auto_update = false,
      toc_list = {
        markers = '-',
        indent_size = 4,

        -- Remove the `#` from the format string so I can generate it myself later
        item_format_string = '${indent}${marker} [${name}](${link})',

        -- Override link formatter to include filename (markdown-oxide doesn't support internal links yet)
        item_formatter = function(item, fmtstr)
          local default_formatter = require('mtoc.config').defaults.toc_list.item_formatter
          item.link = get_file_name() .. '#' .. item.name
          return default_formatter(item, fmtstr)
        end,
      },
    },
  },

  {
    -- A simple and useful set of toggle commands for Markdown
    'roodolv/markdown-toggle.nvim',
    config = function()
      local mt = require 'markdown-toggle'
      ---@diagnostic disable-next-line: missing-fields
      mt.setup {}

      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, {
          -- expr must be enabled for NORMAL mode dot-repeat to work
          expr = mode == 'n',
          desc = desc,
        })
      end

      -- stylua: ignore start

      -- Auto-continue list
      vim.keymap.set('n', 'o',    mt.autolist_down)
      vim.keymap.set('n', 'O',    mt.autolist_up)
      vim.keymap.set('i', '<CR>', mt.autolist_cr)

      -- NORMAL
      map('n', '<M-x>', mt.checkbox_dot, 'Toggle checkbox')
      map('n', '<M-u>', mt.list_dot,     'Toggle unordered list')
      map('n', '<M-o>', mt.olist_dot,    'Toggle ordered list')
      map('n', '<M-q>', mt.quote_dot,    'Toggle quote')

      -- VISUAL
      map('x', '<M-x>', mt.checkbox, 'Toggle checkbox')
      map('x', '<M-u>', mt.list,     'Toggle unordered list')
      map('x', '<M-o>', mt.olist,    'Toggle ordered list')
      map('x', '<M-q>', mt.quote,    'Toggle quote')

      -- stylua: ignore end
    end,
  },
}
