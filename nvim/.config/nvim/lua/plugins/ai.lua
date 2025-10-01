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
          -- enabled = false,
          enabled = function()
            return not vim.g.disable_nes and not vim.b.disable_nes
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

      map({ 'n', 'x', 'i', 't' }, '<c-.>', function()
        cli.toggle()
      end, { desc = 'Sidekick Switch Focus' })

      map({ 'n', 'v' }, '<leader>aa', function()
        cli.toggle { focus = true }
      end, { desc = 'Sidekick Toggle CLI' })
      map({ 'n', 'v' }, '<leader>ap', function()
        cli.select_prompt()
      end, { desc = 'Sidekick Ask Prompt' })

      map({ 'n', 'v' }, '<leader>ac', function()
        cli.toggle { name = 'copilot', focus = true }
      end, { desc = 'Sidekick Copilot Toggle' })
      map({ 'n', 'v' }, '<leader>ag', function()
        cli.toggle { name = 'gemini', focus = true }
      end, { desc = 'Sidekick Gemini Toggle' })
      map({ 'n', 'v' }, '<leader>ax', function()
        cli.toggle { name = 'codex', focus = true }
      end, { desc = 'Sidekick Codex Toggle' })
    end,
  },
}
