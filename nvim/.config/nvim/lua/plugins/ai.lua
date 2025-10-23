-- Disable next edit suggestions by default
-- They can easily be toggled on when needed
vim.g.disable_nes = true

return {
  {
    -- Github Copilot integration
    'zbirenbaum/copilot.lua',
    enabled = vim.g.work_profile,
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = false,
      },
    },
  },

  {
    -- Your Neovim AI sidekick
    'folke/sidekick.nvim',
    enabled = vim.g.work_profile,
    event = 'VeryLazy',
    config = function()
      local sidekick = require 'sidekick'
      local cli = require 'sidekick.cli'

      sidekick.setup {
        nes = {
          enabled = function()
            return vim.g.disable_nes ~= true and vim.b.disable_nes ~= true
          end,

          diff = {
            inline = false,
          },
        },
        cli = {
          win = {
            -- Open in a floating window rather than re-arranging existing splits
            layout = 'float',
            -- Make the floating window fullscreen
            float = {
              width = 1,
              height = 1,
            },
          },
        },
      }

      local map = function(mode, keys, func, desc, opts)
        opts = opts or {}
        opts.desc = 'Sidekick: ' .. desc
        vim.keymap.set(mode, keys, func, opts)
      end

      -- Jump to next suggestion OR apply it OR fallback to <tab>
      map('n', '<Tab>', function()
        return sidekick.nes_jump_or_apply() and '' or '<Tab>'
      end, 'Goto/Apply Next Edit Suggestion', { expr = true })

      -- stylua: ignore start

      map({ 'n', 'x', 't' }, '<c-.>', function() cli.toggle() end, 'Toggle CLI')
      map({ 'n', 'x' }, '<leader>aa', function() cli.select() end, 'Select CLI')
      map({ 'n', 'x' }, '<leader>ap', function() cli.prompt() end, 'Prompt')

      local send = function(msg)
        return function() cli.send { msg = msg } end
      end

      -- Send current file path
      map({ 'n', 'x' }, '<leader>af', send '{file}',      'Send File')
      -- Send current file path w/ cursor position, or line range for visual selection
      map({ 'n', 'x' }, '<leader>at', send '{this}',      'Send file & position')
      -- Send selection as code snippet
      map({ 'x' },      '<leader>av', send '{selection}', 'Send visual selection')

      -- stylua: ignore end
    end,
  },
}
