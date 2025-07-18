return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            desc = 'Git: ' .. (desc or '?'),
          })
        end

        local nav_hunk = function(direction)
          gitsigns.nav_hunk(direction, { target = 'all' })
        end
        local blame_line = function()
          gitsigns.blame_line { full = true }
        end
        local diffthis_previous = function()
          gitsigns.diffthis '~1'
        end
        local setqflist_all = function()
          ---@diagnostic disable-next-line: param-type-mismatch
          gitsigns.setqflist 'all'
        end

        -- stylua: ignore start

        -- Navigation
        -- Using `h` for 'hunk'. Avoiding `c` since it conflicts with `mini.bracketed`.
        map('n', ']h', function() nav_hunk('next')  end, 'Next hunk')
        map('n', '[h', function() nav_hunk('prev')  end, 'Prev hunk')
        map('n', ']H', function() nav_hunk('last')  end, 'Last Hunk')
        map('n', '[H', function() nav_hunk('first') end, 'First Hunk')

        -- Staging
        local nv = {'n', 'v'}
        map(nv,  '<leader>hs', gitsigns.stage_hunk,          '[S]tage hunk (toggle)')
        map(nv,  '<leader>hr', gitsigns.reset_hunk,          '[R]eset hunk')
        map('n', '<leader>hS', gitsigns.stage_buffer,        '[S]tage entire buffer')
        map('n', '<leader>hR', gitsigns.reset_buffer,        '[R]eset entire buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk_inline, '[P]review hunk (inline)')
        -- Blame
        map('n', '<leader>hb', blame_line, '[B]lame line')
        -- Diff
        map('n', '<leader>hd', gitsigns.diffthis, '[D]iff file')
        map('n', '<leader>hD', diffthis_previous, '[D]iff file vs. previous commit')
        -- Quickfix
        map('n', '<leader>hq', gitsigns.setqflist, 'Send [H]unks to [Q]uickfix (current buffer)')
        map('n', '<leader>hQ', setqflist_all,      'Send [H]unks to [Q]uickfix (all files)')

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle [B]lame (inline)')
        map('n', '<leader>td', gitsigns.toggle_word_diff,          '[T]oggle Word [D]iff')

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk, '[I]nner [H]unk')

        -- stylua: ignore end
      end,
    },
  },

  {
    -- A Git wrapper so awesome, it should be illegal
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      -- stylua: ignore start
      { '<leader>gg', '<cmd>tab G<cr>',      desc = '[G]it Open Fugitive' },
      { '<leader>gb', '<cmd>Git blame<cr>',  desc = '[G]it [B]lame' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = '[G]it [C]ommit' },
      { '<leader>gp', '<cmd>Git push<cr>',   desc = '[G]it [P]ush' },
      { '<leader>gl', '<cmd>Git pull<cr>',   desc = '[G]it Pul[L]' },
      -- stylua: ignore end
    },
  },
}
