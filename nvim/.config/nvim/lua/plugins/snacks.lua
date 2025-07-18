return {
  -- 🍿 A collection of QoL plugins for Neovim
  'folke/snacks.nvim',
  priority = 100,
  lazy = false,

  -- Two important keymaps to use while in a picker are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Snacks picker. This is really useful to discover what snacks-picker can
  -- do as well as how to actually do it!
  config = function()
    -- [[ Configure Snacks Pickers ]]
    -- See `:help snacks-picker` and `:help snacks-picker-setup`
    require('snacks').setup {
      picker = {
        -- Replace `vim.ui.select` with the snacks picker
        ui_select = true,

        layout = {
          -- Default to fullscreen (can still be overridden by source or at call level)
          fullscreen = true,
        },

        sources = {
          buffers = { current = false },
          files = { hidden = true },
          grep = { hidden = true },
          grep_word = { hidden = true },
        },

        win = {
          input = {
            keys = {
              ['<C-c>'] = { 'cancel', mode = { 'n', 'i' } },
              ['<C-/>'] = { 'toggle_help_input', mode = { 'n', 'i' } },
            },
          },
        },

        formatters = {
          file = {
            -- Increase file path max length
            truncate = 75,
          },
        },

        debug = {
          scores = false,
        },
      },
    }

    local picker = require 'snacks.picker'

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      -- Allow binding the same func to multiple keys
      if type(keys) == 'string' then
        keys = { keys }
      end
      for _, key in ipairs(keys) do
        vim.keymap.set(mode, key, func, { desc = desc })
      end
    end

    -- Add shorthands for some longer picker invocations
    local errors_buffer = function()
      picker.diagnostics_buffer { severity = 'ERROR' }
    end
    local errors = function()
      picker.diagnostics { severity = 'ERROR' }
    end
    local directories = function()
      picker.files {
        cmd = 'fd',
        args = { '--type', 'd' },
        transform = function(item)
          -- Filter out non-directories since the it always adds `--type f` -_-
          return vim.fn.isdirectory(item.file) == 1
        end,
        layout = { hidden = { 'preview' } },
      }
    end

    -- See `:h snacks-pickers-sources`
    -- stylua: ignore start

    -- Misc
    map('<leader><leader>', picker.buffers,    '[ ] Switch buffers')
    map('<leader>/',        picker.lines,      '[/] Search in current buffer')
    map('<leader>gs',       picker.git_status, '[G]it [S]tatus')
    map('<leader>fr',       picker.resume,     '[F]ind: [R]esume')
    map('<leader>sr',       picker.resume,     '[S]earch: [R]esume')

    -- Search [H]elp
    map({'<leader>Hh', '<leader>HH'}, picker.help,     '[H]elp: [H]elp')
    map({'<leader>Hc', '<leader>HC'}, picker.commands, '[H]elp: [C]ommands')
    map({'<leader>Hk', '<leader>HK'}, picker.keymaps,  '[H]elp: [K]eybinds')
    map({'<leader>Hp', '<leader>HP'}, picker.pickers,  '[H]elp: [P]ickers')

    -- [F]ind files (or directories!)
    map('<leader>ff', picker.smart,  '[F]ind: [F]iles')
    map('<leader>fo', picker.recent, '[F]ind: [O]ldfiles')
    map('<leader>fd', directories,   '[F]ind: [D]irectories')

    -- [S]earch for strings (lines, contents, etc)
    map('<leader>ss', picker.grep,         '[S]earch: [S]tring')
    map('<leader>sg', picker.grep,         '[S]earch: [G]rep')
    map('<leader>sb', picker.grep_buffers, '[S]earch: within open [B]uffers')

    -- [S]earch for diagnostics/errors
    map('<leader>sd', picker.diagnostics_buffer, '[S]earch: [D]iagnostics (buffer)')
    map('<leader>sD', picker.diagnostics,        '[S]earch: [D]iagnostics (global)')
    map('<leader>se', errors_buffer,             '[S]earch: [E]rrors (buffer)')
    map('<leader>sE', errors,                    '[S]earch: [E]rrors (global)')

    -- [S]earch for current word/visual selection
    map('<leader>sw', picker.grep_word, '[S]earch: current [W]ord', { 'n', 'x' })
    map('<leader>s',  picker.grep_word, '[S]earch: current visual selection', 'v')

    -- [S]earch/[F]ind within my nvim config
    local config = vim.fn.stdpath 'config'
    map('<leader>fv', function() picker.files { cwd = config } end, '[F]ind: [V]im config')
    map('<leader>sv', function() picker.grep  { cwd = config } end, '[S]earch: [V]im config')

    -- [S]earch/[F]ind within my notes directory
    map('<leader>fn', function() picker.files { cwd = '~/notes' } end, '[F]ind: [N]otes')
    map('<leader>sn', function() picker.grep  { cwd = '~/notes' } end, '[S]earch: [N]otes')

    -- stylua: ignore end
  end,
}
