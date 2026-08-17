-- Set the preview title to the full (relative) file path
local set_preview_title = function(picker, item)
  vim.schedule(function()
    if item ~= nil then
      picker.preview.win:set_title(vim.fn.fnamemodify(item.file, ':~:.'))
    end
  end)
end

local grep = {
  hidden = true,
  layout = { hidden = { 'preview' } },
  on_change = set_preview_title,
}

-- 🍿 A collection of QoL plugins for Neovim
-- Snacks doesn't let you call `setup` more than once, so we need to do all our setup here :/
require('snacks').setup {
  -- A file explorer for snacks (actually a picker in disguise)
  explorer = {
    replace_netrw = false,
  },

  -- Replace input prompts with a fancy modal (see `:h vim.ui.input`)
  input = {},

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
      buffers = {
        current = false,
        layout = { hidden = { 'preview' } },
      },
      smart = {
        on_change = set_preview_title,
      },
      files = {
        hidden = true,
        on_change = set_preview_title,
      },
      grep = grep,
      grep_word = grep,
      grep_buffers = grep,
      explorer = {
        hidden = true,
        auto_close = false,
        layout = { fullscreen = false },
      },
      colorschemes = {
        layout = { preset = 'select', fullscreen = false, hidden = {} },
      },
      icons = {
        layout = { preset = 'select', fullscreen = false },
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

  -- Create and toggle terminal windows
  terminal = {
    win = {
      position = 'float',
      width = 0,
      height = 0.5,
      min_height = 25,
      border = 'rounded',
      backdrop = 80,
      row = 0.99, -- Align to bottom
    },
  },

  -- A pretty notification provider
  notifier = {
    timeout = 5000,

    -- Don't group by level
    sort = { 'added' },
  },
}

local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

-- Set up terminal
map({ 'n', 't' }, '<C-t>', Snacks.terminal.toggle, { desc = 'Toggle terminal' })

-- Set up Git browse
cmd('GitBrowse', 'lua Snacks.gitbrowse()', { desc = 'Open file in browser' })

-- Set up notifier
cmd('Notifications', 'lua Snacks.notifier.show_history()', { desc = 'Notification history' })

-- Set up explorer
map('n', '\\', '<cmd>lua Snacks.explorer()<cr>', { desc = 'File Explorer' })
