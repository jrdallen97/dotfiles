return {
  {
    -- Colorscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('catppuccin').setup { flavour = 'macchiato' }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Improvements to netrw. Press `I` to toggle the help back on!
  -- 'tpope/vim-vinegar',

  -- Pairs of handy bracket mappings
  'tpope/vim-unimpaired',

  {
    -- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        -- Replace netrw
        default_file_explorer = true,
        -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
        skip_confirm_for_simple_edits = true,

        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
      }

      -- Mimic the vim-vinegar method of navigating to the parent directory of a file
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  {
    -- Automatic indentation style detection for Neovim
    'nmac427/guess-indent.nvim',
    config = {
      filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
        'netrw',
        'tutor',
        'go',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Load before all the UI elements are loaded
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>e', group = '[E]dit' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]orkspace' },
      },
    },
  },

  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
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
          -- Defaults
          -- add = 'sa', -- Add surrounding in Normal and Visual modes
          -- delete = 'sd', -- Delete surrounding
          -- find = 'sf', -- Find surrounding (to the right)
          -- find_left = 'sF', -- Find surrounding (to the left)
          -- highlight = 'sh', -- Highlight surrounding
          -- replace = 'sr', -- Replace surrounding
          -- update_n_lines = 'sn', -- Update `n_lines` (the number of lines within which surrounding is searched)
          -- suffix_last = 'l', -- Suffix to search with "prev" method
          -- suffix_next = 'n', -- Suffix to search with "next" method

          -- vim-surround-like settings:
          -- add = 'ys', -- Add surrounding in Normal and Visual modes
          -- delete = 'ds', -- Delete surrounding
          -- find = '', -- Find surrounding (to the right)
          -- find_left = '', -- Find surrounding (to the left)
          -- highlight = '', -- Highlight surrounding
          -- replace = 'cs', -- Replace surrounding
          -- update_n_lines = '', -- Update `n_lines`

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

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  {
    -- A collection of small QoL plugins for Neovim
    'folke/snacks.nvim',
    opts = {
      indent = {},
    },
  },
}
