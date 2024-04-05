return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- local map = function(keys, func, desc, mode)
        --   mode = mode or 'n'
        --   vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        -- end
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, {
            buffer = bufnr,
            desc = 'Git: ' .. desc,
          })
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.next_hunk()
          end
        end, 'Next hunk')
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.prev_hunk()
          end
        end, 'Prev hunk')

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, '[H]unk [S]tage')
        map('n', '<leader>hr', gitsigns.reset_hunk, '[H]unk [R]eset')
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, '[H]unk [S]tage')
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, '[H]unk [R]eset')
        map('n', '<leader>hS', gitsigns.stage_buffer, '[H]unk [S]tage all')
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, '[H]unk [U]ndo stage')
        map('n', '<leader>hR', gitsigns.reset_buffer, '[H]unk [R]eset all')
        map('n', '<leader>hp', gitsigns.preview_hunk, '[H]unk [P]review')
        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, '[B]lame line')
        map('n', '<leader>hd', gitsigns.diffthis, '[D]iff')
        map('n', '<leader>hD', function()
          gitsigns.diffthis '~'
        end, '[D]iff ~')
        map('n', '<leader>td', gitsigns.toggle_deleted, '[T]oggle [D]eleted lines')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },

  {
    -- A git interface for Neovim, inspired by Magit
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
    keys = {
      { '<leader>nn', '<cmd>Neogit<cr>', { desc = '[N]eogit' } },
      { '<leader>nc', '<cmd>Neogit commit<cr>', { desc = '[N]eogit [C]ommit' } },
    },
  },
}
