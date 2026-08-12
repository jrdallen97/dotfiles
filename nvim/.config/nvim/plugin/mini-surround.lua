-- Reverse string & flip paired brackets
local mirror = function(s)
  s = s:reverse()
  local chars = {
    ['%('] = ')',
    ['%['] = ']',
    ['%{'] = '}',
    ['%<'] = '>',
  }
  for a, b in pairs(chars) do
    s = s:gsub(a, b)
  end
  return s
end

-- Add/delete/replace surroundings (brackets, quotes, etc.)
require('mini.surround').setup {
  -- Override mappings to be more like tpope/vim-surround
  -- The defaults conflict with the standard vim `s` (remove char & enter insert mode)
  mappings = {
    add = 'ss', -- Add surrounding in Normal and Visual modes
    delete = 'ds', -- Delete surrounding
    replace = 'cs', -- Replace surrounding

    -- Turn off the bindings I never use
    find = '', -- Find surrounding (to the right)
    find_left = '', -- Find surrounding (to the left)
    highlight = '', -- Highlight surrounding
    suffix_last = '', -- Suffix to search with "prev" method
    suffix_next = '', -- Suffix to search with "next" method
  },
  custom_surroundings = {
    -- Allow generic string surrounds
    s = {
      input = function()
        local s = MiniSurround.user_input 'Enter surrounding string'
        if s and s ~= '' then
          return { vim.pesc(s) .. '().-()' .. vim.pesc(s) }
        end
      end,
      output = function()
        local s = MiniSurround.user_input 'Enter surrounding string'
        if s and s ~= '' then
          return { left = s, right = s }
        end
      end,
    },
    -- Allow generic mirrored string surrounds
    m = {
      input = function()
        local s = MiniSurround.user_input 'Enter left string (will be mirrored to right)'
        if s and s ~= '' then
          return { vim.pesc(s) .. '().-()' .. vim.pesc(mirror(s)) }
        end
      end,
      output = function()
        local s = MiniSurround.user_input 'Enter left string (will be mirrored to right)'
        if s and s ~= '' then
          return { left = s, right = mirror(s) }
        end
      end,
    },

    -- Markdown bold
    B = {
      input = { '%*%*().-()%*%*' },
      output = { left = '**', right = '**' },
    },
    -- Markdown hyperlink
    h = {
      input = { '%[().-()%]%(.-%)' },
      output = function()
        local link = MiniSurround.user_input 'Link: '
        return { left = '[', right = '](' .. link .. ')' }
      end,
    },
  },
}

-- Don't change builtin `s` binding!
vim.api.nvim_del_keymap('n', 's')
