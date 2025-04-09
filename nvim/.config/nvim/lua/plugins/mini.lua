return {
  -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      -- Override mappings to be more like tpope/vim-surround
      -- The defaults conflict with the standard vim `s` (remove char & enter insert mode)
      mappings = {
        -- Custom: disable some of the default bindings
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = '', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = '', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = '', -- Update `n_lines`
        suffix_last = '', -- Suffix to search with "prev" method
        suffix_next = '', -- Suffix to search with "next" method
      },
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Override the section for cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l│%2v'
    end

    -- Work with trailing whitespace
    require('mini.trailspace').setup()
    -- Add a command to easily trim whitespace
    vim.api.nvim_create_user_command('TrimWhitespace', function()
      MiniTrailspace.trim()
    end, {})

    -- Split and join arguments
    require('mini.splitjoin').setup()

    -- Move any selection in any direction
    require('mini.move').setup {
      mappings = {
        -- Default mapping (`<M-hjkl>`) doesn't work on mac bc meta is intercepted
        left = '<M-Left>',
        right = '<M-Right>',
        up = '<M-Up>',
        down = '<M-Down>',

        line_left = '<M-Left>',
        line_right = '<M-Right>',
        line_up = '<M-Up>',
        line_down = '<M-Down>',
      },
    }

    -- Text edit operators (e.g. evaluate text, duplicate text)
    require('mini.operators').setup {
      -- Disable exchange (default map conflicts with `gx` + it doesn't seem very useful)
      exchange = { prefix = '' },
      replace = { prefix = '' },
    }

    -- Go forward/backward with square brackets
    require('mini.bracketed').setup {
      -- Disable the weird ones
      treesitter = { suffix = '' },
      undo = { suffix = '' },
      yank = { suffix = '' },
    }

    -- Icon provider
    require('mini.icons').setup {
      style = vim.g.have_nerd_font and 'glyph' or 'ascii',
    }

    -- Visualize and work with indent scope
    require('mini.indentscope').setup {
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.linear {
          easing = 'out',
          duration = 10,
          unit = 'step',
        },
      },
      options = {
        -- Ignore cursor column when calculating current scope
        -- indent_at_cursor = false,
        -- Use inner scope when used on a scope border (e.g. function header)
        try_as_border = true,
      },
      -- Use the same symbol as 'indent-blankline.nvim'
      symbol = '▎',
    }

    -- Session management (read, write, delete)
    require('mini.sessions').setup {
      -- Whether to read default session if Neovim opened without file arguments
      autoread = false,
      -- Whether to print session path after action
      verbose = { read = true, write = true, delete = true },
    }
    -- Add a command to easily save/create a new session
    vim.api.nvim_create_user_command('Save', function(opts)
      MiniSessions.write(opts.args)
    end, { nargs = 1, desc = 'mini.sessions: Save session' })
    vim.api.nvim_create_user_command('Resume', function()
      MiniSessions.read(MiniSessions.get_latest())
    end, { nargs = 0, desc = 'mini.sessions: Resume most recent session' })
    vim.api.nvim_create_user_command('Sessions', function()
      MiniSessions.select()
    end, { nargs = 0, desc = 'mini.sessions: Select session' })

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
  init = function()
    -- Make 'mini.icons' pretend to be 'nvim-web-devicons'
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
