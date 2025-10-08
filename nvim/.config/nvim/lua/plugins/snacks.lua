return {
  -- 🍿 A collection of QoL plugins for Neovim
  'folke/snacks.nvim',
  priority = 100,
  lazy = false,
  opts = {
    -- A modern fuzzy-finder to navigate the Neovim universe
    -- See `:help snacks-picker` and `:help snacks-picker-setup`
    picker = {
      -- Replace `vim.ui.select` with the snacks picker
      ui_select = true,

      layout = {
        -- Default to fullscreen (can still be overridden by source or at call level)
        fullscreen = true,
      },

      -- Tweak the default settings for each source
      sources = {
        buffers = { current = true },
        files = { hidden = true },
        grep = { hidden = true },
        grep_word = { hidden = true },
      },

      win = {
        input = {
          keys = {
            ['<C-c>'] = { 'cancel', mode = { 'n', 'i' } },
            ['<C-/>'] = { 'toggle_help_input', mode = { 'n', 'i' } },
            ['<PageUp>'] = { 'list_scroll_up', mode = { 'n', 'i' } },
            ['<PageDown>'] = { 'list_scroll_down', mode = { 'n', 'i' } },
          },
        },
      },

      formatters = {
        file = {
          -- Increase file path max length
          truncate = 100,
          -- Show filename before the path to ensure it's always visible
          filename_first = true,
        },
      },

      debug = {
        scores = false,
      },
    },

    -- Toggle keymaps integrated with which-key icons/colors
    toggle = {
      -- Override which-key descriptions to use a static "Toggle" prefix (rather than Enable/Disable)
      wk_desc = { enabled = 'Toggle ', disabled = 'Toggle ' },
    },

    -- A pretty notification provider
    notifier = {
      timeout = 5000,
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    local cmd = vim.api.nvim_create_user_command
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

    -- Set up picker
    do
      local picker = Snacks.picker

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
          -- TODO: Add keybind to chain into another search?
        }
      end

      -- See `:h snacks-pickers-sources`
      -- stylua: ignore start

      -- Misc
      map('<leader><leader>', picker.buffers,    'Switch buffers')
      map('<leader>/',        picker.smart,      'Smart finder')
      map('<leader>gs',       picker.git_status, 'Git Status')
      map('<leader>fr',       picker.resume,     'Resume')
      map('<leader>sr',       picker.resume,     'Resume')

      -- Search Help
      map({'<leader>Hh', '<leader>HH'}, picker.help,     'Help')
      map({'<leader>Hc', '<leader>HC'}, picker.commands, 'Commands')
      map({'<leader>Hk', '<leader>HK'}, picker.keymaps,  'Keybinds')
      map({'<leader>Hp', '<leader>HP'}, picker.pickers,  'Pickers')

      -- Find files (or directories!)
      map('<leader>ff', picker.files,  'Files')
      map('<leader>fo', picker.recent, 'Oldfiles')
      map('<leader>fd', directories,   'Directories')
      map('<leader>fs', picker.smart,  'Smart finder')

      -- Search for strings (lines, contents, etc)
      map('<leader>ss', picker.grep,         'String')
      map('<leader>sg', picker.grep,         'Grep')
      map('<leader>sl', picker.lines,        'Lines in current buffer')
      map('<leader>sb', picker.grep_buffers, 'Lines in all buffers')

      -- Search for diagnostics/errors
      map('<leader>sd', picker.diagnostics_buffer, 'Diagnostics (buffer)')
      map('<leader>sD', picker.diagnostics,        'Diagnostics (global)')
      map('<leader>se', errors_buffer,             'Errors (buffer)')
      map('<leader>sE', errors,                    'Errors (global)')

      -- Search for current word/visual selection
      map('<leader>sw', picker.grep_word, 'Current Word', { 'n', 'x' })

      -- Search/Find within my nvim config
      local config = vim.fn.stdpath 'config'
      map('<leader>fv', function() picker.files { cwd = config } end, 'Vim config')
      map('<leader>sv', function() picker.grep  { cwd = config } end, 'Vim config')

      -- Search/Find within my notes directory
      map('<leader>fn', function() picker.files { cwd = '~/notes' } end, 'Notes')
      map('<leader>sn', function() picker.grep  { cwd = '~/notes' } end, 'Notes')

      -- stylua: ignore end

      -- Fix bug where snacks.picker opens files in the wrong window
      -- https://github.com/folke/snacks.nvim/pull/2012
      local M = require 'snacks.picker.core.main'
      M.new = function(opts)
        opts = vim.tbl_extend('force', {
          float = false,
          file = true,
          current = false,
        }, opts or {})
        local self = setmetatable({}, M)
        self.opts = opts
        self.win = vim.api.nvim_get_current_win()
        return self
      end
    end

    -- Set up toggle
    do
      local t = Snacks.toggle

      -- Simple toggles
      t.option('wrap', { name = 'Wrap' }):map '<leader>tw'
      t.diagnostics({ name = 'Errors (diagnostics)' }):map '<leader>te'

      -- stylua: ignore start

      -- Toggle ruler
      t.new({
        id = 'ruler',
        name = 'Ruler',
        get = function()
          return vim.o.colorcolumn ~= ''
        end,
        set = function(enabled)
          vim.o.colorcolumn = enabled and '100' or ''
        end,
      }):map '<leader>tr'

      -- Easily switch between light & dark mode
      t.new({
        id = 'light-mode',
        name = 'Light mode',
        get = function()
          return vim.o.bg == 'light'
        end,
        set = function(enabled)
          vim.cmd.colorscheme(enabled and 'bamboo' or 'catppuccin')
          vim.o.bg = enabled and 'light' or 'dark'
        end,
      }):map '<leader>tl'

      -- Auto-format
      t.new({
        id = 'format-on-save-buffer',
        name = 'Format-on-save (buffer)',
        get = function()
          return not vim.b.disable_autoformat
        end,
        set = function(disabled)
          vim.b.disable_autoformat = not disabled
        end,
      }):map '<leader>tf'
      t.new({
        id = 'format-on-save-global',
        name = 'Format-on-save (global)',
        get = function()
          return not vim.g.disable_autoformat
        end,
        set = function(disabled)
          vim.g.disable_autoformat = not disabled
        end,
      }):map '<leader>tF'

      -- Autosuggestions
      t.new({
        id = 'autosuggestions',
        name = 'Autosuggestions (global)',
        get = function()
          return not vim.g.disable_autosuggestions
        end,
        set = function(disabled)
          vim.g.disable_autosuggestions = not disabled
        end,
      }):map '<leader>ta'

      -- Next edit suggestions
      t.new({
        id = 'nes-global',
        name = 'Next edit suggestions (global)',
        get = function()
          return not vim.g.disable_nes
        end,
        set = function(disabled)
          vim.g.disable_nes = not disabled
        end,
      }):map '<leader>tn'

      -- stylua: ignore end
    end

    -- Set up notifier
    cmd('Notifications', Snacks.notifier.show_history, { desc = 'Show notification history' })
  end,
}
