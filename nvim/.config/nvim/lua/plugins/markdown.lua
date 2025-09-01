-- Get just the name of the current file (excluding path & extension)
local function get_file_name()
  local file = vim.fn.expand '%'
  local file_name = file:match '[^/]*.md$'
  return file_name:sub(0, #file_name - 3)
end

local markdown_types = { 'markdown', 'markdown.mdx', 'text', 'tex', 'plaintex', 'norg' }
local markdown_augroup = vim.api.nvim_create_augroup('markdown-keybinds', {})

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
    ft = markdown_types,
    config = function()
      local mt = require 'markdown-toggle'
      ---@diagnostic disable-next-line: missing-fields
      mt.setup {
        -- Configure possible checkbox states
        box_table = { 'x', '~' },
        -- Use the above table when cycling/toggling checkboxes
        cycle_box_table = true,
        -- When cycling checkboxes, also include "no checkbox" as the first option
        list_before_box = true,
      }

      local map = function(expr, mode, keys, func, desc)
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
          -- stylua: ignore start

          -- Autolist
          map(false, "n", "O",    mt.autolist_up,   'New bullet above')
          map(false, "n", "o",    mt.autolist_down, 'New bullet below')
          map(false, "i", "<CR>", mt.autolist_cr,   'New bullet below')

          -- NORMAL
          map(true, 'n', '<M-x>', mt.checkbox_dot, 'Toggle checkbox')
          map(true, 'n', '<M-u>', mt.list_dot,     'Toggle unordered list')
          map(true, 'n', '<M-o>', mt.olist_dot,    'Toggle ordered list')
          map(true, 'n', '<M-q>', mt.quote_dot,    'Toggle quote')
          map(true, 'n', '<M-h>', mt.heading_dot,  'Toggle heading')

          -- VISUAL
          map(false, 'x', '<M-x>', mt.checkbox, 'Toggle checkbox')
          map(false, 'x', '<M-u>', mt.list,     'Toggle unordered list')
          map(false, 'x', '<M-o>', mt.olist,    'Toggle ordered list')
          map(false, 'x', '<M-q>', mt.quote,    'Toggle quote')
          map(false, 'x', '<M-h>', mt.heading,  'Toggle heading')

          -- stylua: ignore end
        end,
      })
    end,
  },

  {
    -- Automatic list continuation and formatting
    'gaoDean/autolist.nvim',
    ft = markdown_types,
    config = function()
      require('autolist').setup {}

      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = 0, desc = desc })
      end

      -- Create keybinds in an autocmd so they're properly attached to all buffers
      vim.api.nvim_create_autocmd('FileType', {
        desc = 'autolist.nvim keymaps',
        pattern = markdown_types,
        group = markdown_augroup,
        callback = function()
          -- Toggle checkbox w/ enter
          map('n', '<CR>', '<cmd>AutolistToggleCheckbox<cr><cr>', 'Toggle checkbox')

          -- Automatically recalculate list numbering when deleting items
          map('n', 'dd', 'dd<cmd>AutolistRecalculate<cr>', 'Delete line & recalculate list')
          map('v', 'd', 'd<cmd>AutolistRecalculate<cr>', 'Delete selection & recalculate list')

          -- Manually recalculate list numbering
          map('n', '<M-r>', '<cmd>AutolistRecalculate<cr>', 'Recalculate list')
        end,
      })
    end,
  },
}
