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
    notifier = {},
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    -- Set up picker
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
    local files = function()
      picker.smart {
        multi = { 'files' },
      }
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
    map('<leader>/',        picker.smart,      '[/] Smart finder')
    map('<leader>gs',       picker.git_status, '[G]it [S]tatus')
    map('<leader>fr',       picker.resume,     '[R]esume')
    map('<leader>sr',       picker.resume,     '[R]esume')

    -- Search [H]elp
    map({'<leader>Hh', '<leader>HH'}, picker.help,     '[H]elp')
    map({'<leader>Hc', '<leader>HC'}, picker.commands, '[C]ommands')
    map({'<leader>Hk', '<leader>HK'}, picker.keymaps,  '[K]eybinds')
    map({'<leader>Hp', '<leader>HP'}, picker.pickers,  '[P]ickers')

    -- [F]ind files (or directories!)
    map('<leader>ff', files,         '[F]iles')
    map('<leader>fo', picker.recent, '[O]ldfiles')
    map('<leader>fd', directories,   '[D]irectories')

    -- [S]earch for strings (lines, contents, etc)
    map('<leader>ss', picker.grep,         '[S]tring')
    map('<leader>sg', picker.grep,         '[G]rep')
    map('<leader>sl', picker.lines,        '[L]ines in current buffer')
    map('<leader>sb', picker.grep_buffers, 'Within open [B]uffers')

    -- [S]earch for diagnostics/errors
    map('<leader>sd', picker.diagnostics_buffer, '[D]iagnostics (buffer)')
    map('<leader>sD', picker.diagnostics,        '[D]iagnostics (global)')
    map('<leader>se', errors_buffer,             '[E]rrors (buffer)')
    map('<leader>sE', errors,                    '[E]rrors (global)')

    -- [S]earch for current word/visual selection
    map('<leader>sw', picker.grep_word, 'Current [W]ord', { 'n', 'x' })

    -- [S]earch/[F]ind within my nvim config
    local config = vim.fn.stdpath 'config'
    map('<leader>fv', function() picker.files { cwd = config } end, '[V]im config')
    map('<leader>sv', function() picker.grep  { cwd = config } end, '[V]im config')

    -- [S]earch/[F]ind within my notes directory
    map('<leader>fn', function() picker.files { cwd = '~/notes' } end, '[N]otes')
    map('<leader>sn', function() picker.grep  { cwd = '~/notes' } end, '[N]otes')

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

    -- Set up toggle
    local toggle = require 'snacks.toggle'

    -- Simple toggles
    toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
    toggle.diagnostics({ name = 'Errors (diagnostics)' }):map '<leader>te'

    -- stylua: ignore start

    -- Toggle ruler
    toggle.new({
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
    toggle.new({
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
    toggle.new({
      id = 'format-on-save-buffer',
      name = 'Format-on-save (buffer)',
      get = function()
        return not vim.b.disable_autoformat
      end,
      set = function(disabled)
        vim.b.disable_autoformat = not disabled
      end,
    }):map '<leader>tf'
    toggle.new({
      id = 'format-on-save-global',
      name = 'Format-on-save (global)',
      get = function()
        return not vim.g.disable_autoformat
      end,
      set = function(disabled)
        vim.g.disable_autoformat = not disabled
      end,
    }):map '<leader>tF'

    -- stylua: ignore end
  end,
}
