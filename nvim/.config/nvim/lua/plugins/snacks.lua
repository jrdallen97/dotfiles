return {
  -- 🍿 A collection of QoL plugins for Neovim
  'folke/snacks.nvim',
  priority = 100,
  lazy = false,
  opts = {
    -- A file explorer for snacks (actually a picker in disguise)
    explorer = {
      replace_netrw = false,
    },

    -- A modern fuzzy-finder to navigate the Neovim universe
    -- See `:help snacks-picker` and `:help snacks-picker-setup`
    picker = {
      -- Replace `vim.ui.select` with the snacks picker
      ui_select = true,

      layout = {
        -- Default to fullscreen (can still be overridden by source or at call level)
        fullscreen = true,
      },

      main = {
        -- Don't require the main window to be a file
        -- This lets snacks open files into non-standard buffers (e.g. Oil buffers!)
        file = false,
      },

      -- Tweak the default settings for each source
      sources = {
        buffers = { current = true },
        files = { hidden = true },
        grep = { hidden = true },
        grep_word = { hidden = true },
        explorer = {
          hidden = true,
          auto_close = false,
          layout = { fullscreen = false },
        },
        colorschemes = {
          layout = {
            preset = 'select',
            hidden = {},
            fullscreen = false,
          },
        },
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

    -- Open the repo of the active file in the browser (e.g., GitHub)
    gitbrowse = {},

    -- Toggle keymaps integrated with which-key icons/colors
    toggle = {
      -- Override which-key descriptions to use a static "Toggle" prefix (rather than Enable/Disable)
      wk_desc = { enabled = 'Toggle ', disabled = 'Toggle ' },
    },

    -- A pretty notification provider
    notifier = {
      timeout = 5000,

      -- Don't group by level
      sort = { 'added' },
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    local cmd = function(cmd, func, desc)
      vim.api.nvim_create_user_command(cmd, func, { desc = desc })
    end
    local map = function(key, func, desc, mode)
      vim.keymap.set(mode or 'n', key, func, { desc = desc })
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
      map('<leader>gs',       picker.git_status, 'Status')
      map('<leader>fr',       picker.resume,     'Resume')
      map('<leader>sr',       picker.resume,     'Resume')

      -- Search Help
      map('<leader>hh', picker.help,     'Help')
      map('<leader>hc', picker.commands, 'Commands')
      map('<leader>hk', picker.keymaps,  'Keybinds')
      map('<leader>hp', picker.pickers,  'Pickers')
      map('<leader>ht', picker.colorschemes,  'Themes')

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
    end

    -- Set up toggle
    -- stylua: ignore
    do
      -- Simple toggles
      Snacks.toggle.option('wrap' ):map '<leader>tw'
      Snacks.toggle.option('spell'):map '<leader>ts'
      Snacks.toggle.diagnostics(  ):map '<leader>td'

      -- Toggle conceallevel (use `:set cole=` for values other than 2)
      Snacks.toggle.new({
        name = 'conceal',
        get = function()        return vim.o.conceallevel ~= 0          end,
        set = function(enabled) vim.o.conceallevel = enabled and 2 or 0 end,
      }):map '<leader>tc'
      -- Toggle ruler (use `:set cc=` for values other than 100)
      Snacks.toggle.new({
        name = 'ruler',
        get = function()        return vim.o.colorcolumn ~= ''              end,
        set = function(enabled) vim.o.colorcolumn = enabled and '100' or '' end,
      }):map '<leader>tr'

      -- Easily switch between light & dark mode
      Snacks.toggle.new({
        name = 'light mode',
        get = function() return vim.o.bg == 'light' end,
        set = function(enabled)
          vim.cmd.colorscheme(enabled and vim.g.light_scheme or vim.g.dark_scheme)
          vim.o.bg = enabled and 'light' or 'dark'
        end,
      }):map '<leader>tl'

      -- Helper for disable toggles
      local disable = function(name, var, buffer)
        local v = buffer and vim.b or vim.g
        return Snacks.toggle.new({
          name = name .. (buffer and ' (buffer)' or ' (global)'),
          get = function()         return not v[var]     end,
          set = function(disabled) v[var] = not disabled end,
        })
      end

      -- Auto-format
      disable('autoformat', 'disable_autoformat', true ):map '<leader>tf'
      disable('autoformat', 'disable_autoformat', false):map '<leader>tF'

      -- Autosuggestions
      disable('autosuggestions', 'disable_autosuggestions', true ):map '<leader>ta'
      disable('autosuggestions', 'disable_autosuggestions', false):map '<leader>tA'

      -- Next edit suggestions
      disable('next edit suggestions', 'disable_nes', true ):map '<leader>tn'
      disable('next edit suggestions', 'disable_nes', false):map '<leader>tN'
    end

    -- Set up Git browse
    cmd('GitBrowse', 'lua Snacks.gitbrowse()', 'Open file in browser')

    -- Set up notifier
    cmd('Notifications', 'lua Snacks.notifier.show_history()', 'Notification history')

    -- Set up explorer
    map('\\', '<cmd>lua Snacks.explorer()<cr>', 'File Explorer')
  end,
}
