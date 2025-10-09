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
            if not vim.g.work_profile then
              return false
            end
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

      local map = vim.keymap.set

      -- Jump to next suggestion OR apply it OR fallback to <tab>
      map('n', '<Tab>', function()
        if not sidekick.nes_jump_or_apply() then
          return '<Tab>' -- fallback to normal tab
        end
      end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

      -- Toggle CLI
      map({ 'n', 'x', 'i', 't' }, '<c-.>', function()
        cli.toggle()
      end, { desc = 'Sidekick: Toggle CLI' })

      -- Pick CLI
      map({ 'n', 'v' }, '<leader>aa', function()
        cli.select()
      end, { desc = 'Sidekick: Select CLI' })

      -- Select & send preset prompts
      map({ 'n', 'v' }, '<leader>ap', function()
        cli.prompt()
      end, { desc = 'Sidekick: Prompt' })
      -- Send current file path w/ line and cursor position, or line range for visual selection
      map({ 'n', 'v' }, '<leader>at', function()
        cli.send { msg = '{this}' }
      end, { desc = 'Sidekick: This' })
      -- Send selected code snippet
      map({ 'n', 'v' }, '<leader>av', function()
        cli.send { msg = '{selection}' }
      end, { desc = 'Sidekick: Visual Selection' })
      -- Send current file path
      map({ 'n', 'v' }, '<leader>af', function()
        cli.send { msg = '{file}' }
      end, { desc = 'Sidekick: File' })
    end,
  },
}
