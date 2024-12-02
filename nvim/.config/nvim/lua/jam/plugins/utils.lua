-- Get just the name of the current file (excluding path & extension)
local function get_file_name()
  local file = vim.fn.expand '%'
  local file_name = file:match '[^/]*.md$'
  return file_name:sub(0, #file_name - 3)
end

return {
  {
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
}
