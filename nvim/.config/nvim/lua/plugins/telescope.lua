return {
  -- Fuzzy Finder (files, lsp, etc)
  -- 'nvim-telescope/telescope.nvim',
  -- event = 'VimEnter',
  -- dependencies = {
  --   'nvim-lua/plenary.nvim',
  --   { -- If encountering errors, see telescope-fzf-native README for installation instructions
  --     'nvim-telescope/telescope-fzf-native.nvim',
  --
  --     -- `build` is used to run some command when the plugin is installed/updated.
  --     -- This is only run then, not every time Neovim starts up.
  --     build = 'make',
  --
  --     -- `cond` is a condition used to determine whether this plugin should be
  --     -- installed and loaded.
  --     cond = function()
  --       return vim.fn.executable 'make' == 1
  --     end,
  --   },
  --
  --   -- Use a telescope picker for builtin nvim select windows (e.g. LSP code actions)
  --   'nvim-telescope/telescope-ui-select.nvim',
  -- },
  -- config = function()
  --   -- Telescope is a fuzzy finder that comes with a lot of different things that
  --   -- it can fuzzy find! It's more than just a "file finder", it can search
  --   -- many different aspects of Neovim, your workspace, LSP, and more!
  --   --
  --   -- The easiest way to use Telescope, is to start by doing something like:
  --   --  :Telescope help_tags
  --   --
  --   -- After running this command, a window will open up and you're able to
  --   -- type in the prompt window. You'll see a list of `help_tags` options and
  --   -- a corresponding preview of the help.
  --   --
  --   -- Two important keymaps to use while in Telescope are:
  --   --  - Insert mode: <c-/>
  --   --  - Normal mode: ?
  --   --
  --   -- This opens a window that shows you all of the keymaps for the current
  --   -- Telescope picker. This is really useful to discover what Telescope can
  --   -- do as well as how to actually do it!
  --
  --   -- [[ Configure Telescope ]]
  --   -- See `:help telescope` and `:help telescope.setup()`
  --   require('telescope').setup {
  --     -- You can put your default mappings / updates / etc. in here
  --     --  All the info you're looking for is in `:help telescope.setup()`
  --
  --     defaults = {
  --       mappings = {
  --         i = { ['<c-enter>'] = 'to_fuzzy_refine' },
  --       },
  --       layout_strategy = 'flex',
  --       layout_config = { width = 0.99, height = 0.99, prompt_position = 'top' },
  --       path_display = { 'truncate' },
  --       dynamic_preview_title = true,
  --       sorting_strategy = 'ascending',
  --     },
  --     pickers = {
  --       buffers = {
  --         mappings = {
  --           i = {
  --             ['<C-d>'] = require('telescope.actions').delete_buffer,
  --           },
  --           n = {
  --             ['<C-d>'] = require('telescope.actions').delete_buffer,
  --           },
  --         },
  --         -- sort_lastused = true,
  --         sort_mru = true,
  --       },
  --       current_buffer_fuzzy_find = {
  --         -- Disable previewer pane for current-buffer search since it's unnecessary
  --         previewer = false,
  --       },
  --     },
  --   }
  --
  --   -- Enable Telescope extensions if they are installed
  --   pcall(require('telescope').load_extension, 'fzf')
  --   pcall(require('telescope').load_extension, 'ui-select')
  --
  --   -- See `:help telescope.builtin`
  --   local builtin = require 'telescope.builtin'
  --   local map = vim.keymap.set
  --   map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  --   map('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
  --   map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  --   map('n', '<leader>se', builtin.diagnostics, { desc = '[S]earch [E]rrors (diagnostics)' })
  --   map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  --   map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  --   map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  --   map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  --   map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  --   map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  --   map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  --
  --   map('n', '<leader>sd', function()
  --     builtin.find_files {
  --       find_command = { 'fd', '-t=d' },
  --     }
  --   end, { desc = '[S]earch [D]irectories' })
  --
  --   map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
  --
  --   -- It's also possible to pass additional configuration options.
  --   --  See `:help telescope.builtin.live_grep()` for information about particular keys
  --   map('n', '<leader>s/', function()
  --     builtin.live_grep {
  --       grep_open_files = true,
  --       prompt_title = 'Live Grep in Open Files',
  --     }
  --   end, { desc = '[S]earch [/] in Open Files' })
  --
  --   -- Shortcut for searching your neovim configuration files
  --   map('n', '<leader>sv', function()
  --     builtin.live_grep { cwd = vim.fn.stdpath 'config' }
  --   end, { desc = '[S]earch [V]im config' })
  --
  --   -- Enable line numbers in telescope preview
  --   vim.cmd 'autocmd User TelescopePreviewerLoaded setlocal number'
  -- end,
}
