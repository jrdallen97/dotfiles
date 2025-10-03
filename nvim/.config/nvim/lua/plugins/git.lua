return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local config = require('gitsigns.config').config
        local toggle = require 'snacks.toggle'

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
          ---@diagnostic disable-next-line: param-type-mismatch
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
        map(nv,  '<leader>hs', gitsigns.stage_hunk,          'Stage hunk (toggle)')
        map(nv,  '<leader>hr', gitsigns.reset_hunk,          'Reset hunk')
        map('n', '<leader>hS', gitsigns.stage_buffer,        'Stage entire buffer')
        map('n', '<leader>hR', gitsigns.reset_buffer,        'Reset entire buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk_inline, 'Preview hunk (inline)')
        -- Blame
        map('n', '<leader>hb', blame_line, 'Blame line')
        -- Diff
        map('n', '<leader>hd', gitsigns.diffthis, 'Diff file')
        map('n', '<leader>hD', diffthis_previous, 'Diff file vs. previous commit')
        -- Quickfix
        map('n', '<leader>hq', gitsigns.setqflist, 'Send Hunks to Quickfix (current buffer)')
        map('n', '<leader>hQ', setqflist_all,      'Send Hunks to Quickfix (all files)')

        -- Toggles
        toggle.new({
          id = 'git_blame',
          name = 'Git Blame (inline)',
          get = function() return config.current_line_blame end,
          set = gitsigns.toggle_current_line_blame,
        }):map '<leader>tb'
        toggle.new({
          id = 'git_word_diff',
          name = 'Git Word Diff',
          get = function() return config.word_diff end,
          set = gitsigns.toggle_word_diff,
        }):map '<leader>td'

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk, 'Inner Hunk')

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
      { '<leader>gg', '<cmd>tab G<cr>',      desc = 'Git Open Fugitive' },
      { '<leader>gb', '<cmd>Git blame<cr>',  desc = 'Git Blame' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Git Commit' },
      { '<leader>gp', '<cmd>Git push<cr>',   desc = 'Git Push' },
      { '<leader>gl', '<cmd>Git pull<cr>',   desc = 'Git Pull' },
      -- stylua: ignore end
    },
  },
}
