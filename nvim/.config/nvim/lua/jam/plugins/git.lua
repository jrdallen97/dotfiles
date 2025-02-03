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
        -- Using `h` for 'hunk'. Avoiding `c` since it conflicts with `mini.bracketed`.
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk('next', { target = 'all' })
          end
        end, 'Next hunk')
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk('prev', { target = 'all' })
          end
        end, 'Prev hunk')
        -- Also add a version for first/last hunk
        map('n', ']H', function()
          gitsigns.nav_hunk('last', { target = 'all' })
        end, 'Last Hunk')
        map('n', '[H', function()
          gitsigns.nav_hunk('first', { target = 'all' })
        end, 'First Hunk')

        -- Stage/reset
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', '[H]unk Toggle [S]taged')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', '[H]unk [R]eset')
        map('n', '<leader>hS', gitsigns.stage_buffer, '[H]unk [S]tage buffer')
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, '[H]unk [U]ndo stage')
        map('n', '<leader>hR', gitsigns.reset_buffer, '[H]unk [R]eset buffer')
        -- Preview
        map('n', '<leader>hp', gitsigns.preview_hunk, '[H]unk [P]review')
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, '[H]unk preview [I]nline')
        -- Blame
        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, '[B]lame line')
        -- Diff
        map('n', '<leader>hd', gitsigns.diffthis, '[D]iff')
        map('n', '<leader>hD', function()
          gitsigns.diffthis '~'
        end, '[D]iff vs. previous commit (~)')
        -- Quickfix
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

  {
    -- Edit and review GitHub issues and pull requests from the comfort of your favorite editor
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('octo').setup {
        -- Using the local filesystem for review means features like LSP will still work
        use_local_fs = true,
      }
    end,
  },
}
