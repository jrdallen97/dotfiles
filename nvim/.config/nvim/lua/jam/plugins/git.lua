return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            desc = 'Git: ' .. (desc or '?'),
          })
        end

        -- Navigation
        -- Using c to match built-in diff binding, overriding to use git for non-diff buffers
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Next hunk')
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
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
        map('n', '<leader>hS', gitsigns.stage_buffer, '[H]unk [S]tage buffer')
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, '[H]unk [U]ndo stage')
        map('n', '<leader>hR', gitsigns.reset_buffer, '[H]unk [R]eset buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk, '[H]unk [P]review')
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, '[H]unk preview [I]nline')

        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, '[B]lame line')

        map('n', '<leader>hd', gitsigns.diffthis, '[D]iff')
        map('n', '<leader>hD', function()
          gitsigns.diffthis '~'
        end, '[D]iff vs. previous commit (~)')

        map('n', '<leader>hQ', function()
          gitsigns.setqflist 'all'
        end, 'Send [H]unks to [Q]uickfix (all files)')
        map('n', '<leader>hq', gitsigns.setqflist, 'Send [H]unks to [Q]uickfix (current buffer)')

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle [B]lame (inline)')
        map('n', '<leader>td', gitsigns.toggle_deleted, '[T]oggle [D]eleted lines')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '[I]nner [H]unk')
      end,
    },
  },

  {
    -- A Git wrapper so awesome, it should be illegal
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      { '<leader>gg', '<cmd>tab G<cr>', desc = '[G]it Open Fugitive' },
      { '<leader>gb', '<cmd>Git blame<cr>', desc = '[G]it [B]lame' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = '[G]it [C]ommit' },
      { '<leader>gp', '<cmd>Git push<cr>', desc = '[G]it [P]ush' },
      { '<leader>gl', '<cmd>Git pull<cr>', desc = '[G]it Pul[L]' },
    },
  },
}
