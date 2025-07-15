return {
  -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    local map = vim.keymap.set
    local cmd = vim.api.nvim_create_user_command

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
        add = 'ss', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        find = '', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = '', -- Highlight surrounding
        replace = 'cs', -- Replace surrounding
        update_n_lines = '', -- Update `n_lines`
        suffix_last = '', -- Suffix to search with "prev" method
        suffix_next = '', -- Suffix to search with "next" method
      },
    }

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
      autoread = true,

      -- File for local session
      file = 'session.vim',

      -- Whether to print session path after action
      verbose = { read = true, write = true, delete = true },
    }

    -- Save/create session
    cmd('Save', function(opts)
      MiniSessions.write(opts.fargs[1])
    end, { nargs = '?', desc = 'mini.sessions: Save/create session' })
    -- Save/create local session
    cmd('SaveLocal', function()
      MiniSessions.write('session.vim', { force = true })
    end, { nargs = 0, desc = 'mini.sessions: Save/create local session' })
    -- Resume most recent session
    cmd('Resume', function()
      MiniSessions.read(MiniSessions.get_latest())
    end, { nargs = 0, desc = 'mini.sessions: Resume most recent session' })
    -- Select a session to load
    cmd('Load', function()
      MiniSessions.select 'read'
    end, { nargs = 0, desc = 'mini.sessions: Load session' })
    -- Select a session to delete
    cmd('RmSession', function()
      MiniSessions.select 'delete'
    end, { nargs = 0, desc = 'mini.sessions: Delete session' })

    -- Also add some keybinds
    map('n', '<leader>lr', ':Resume<cr>', { desc = 'mini.sessions: Resume most recent session' })
    map('n', '<leader>ll', ':Load<cr>', { desc = 'mini.sessions: Load session' })

    -- Set up terminal background synchronization
    -- (prevents black borders if terminal size isn't perfectly aligned)
    require('mini.misc').setup_termbg_sync()

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
  init = function()
    -- Make 'mini.icons' pretend to be 'nvim-web-devicons'
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end

    -- Disable indentscope in certain buffers
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'fzf',
        'help',
        'lazy',
        'mason',
        'neo-tree',
        'trouble',
        'Trouble',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
