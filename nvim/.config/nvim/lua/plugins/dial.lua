return {
  {
    -- Enhanced increment/decrement plugin for Neovim
    'monaqa/dial.nvim',
    config = function()
      local augend = require 'dial.augend'

      require('dial.config').augends:register_group {
        default = {
          -- Numbers
          augend.integer.alias.decimal,
          augend.constant.alias.bool,

          -- Letters
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,

          -- Date/time
          augend.date.alias['%Y/%m/%d'],
          augend.date.alias['%Y-%m-%d'],
          augend.date.alias['%H:%M:%S'],
          augend.date.alias['%H:%M'],

          -- Days of the week
          augend.constant.new {
            elements = { 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' },
            word = true,
            cyclic = true,
            preserve_case = true,
          },
          augend.constant.new {
            elements = { 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' },
            word = true,
            cyclic = true,
            preserve_case = true,
          },

          -- Misc
          augend.semver.alias.semver,
        },
      }

      local map = function(lhs, rhs, desc)
        return vim.keymap.set({ 'n', 'x' }, lhs, rhs, { desc = 'Dial: ' .. desc })
      end

      -- Register keybinds
      map('<C-a>', '<Plug>(dial-increment)', 'Increment')
      map('<C-x>', '<Plug>(dial-decrement)', 'Decrement')
      map('g<C-a>', '<Plug>(dial-g-increment)', 'gIncrement')
      map('g<C-x>', '<Plug>(dial-g-decrement)', 'gDecrement')
    end,
  },
}
