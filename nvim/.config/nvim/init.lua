-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable nerd font icons by default (can be overridden by `local.lua`)
vim.g.have_nerd_font = false

vim.g.bigfile_size = 1 * 1024 * 1024 -- 1MiB
vim.g.hugefile_size = 10 * 1024 * 1024 -- 10MiB

-- Run build steps whenever vim.pack installs or updates a plugin.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    if event.data.kind == 'delete' then
      return
    end

    if event.data.spec.name == 'LuaSnip' then
      -- Build step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      if vim.fn.has 'win32' == 0 and vim.fn.executable 'make' == 1 then
        vim.system({ 'make', 'install_jsregexp' }, { cwd = event.data.path })
      end
    elseif event.data.spec.name == 'nvim-treesitter' then
      vim.cmd.packadd 'nvim-treesitter'
      vim.cmd 'TSUpdate'
    end
  end,
})

-- Load config
require 'settings'
-- Catch the error if `local.lua` doesn't exist
if not pcall(require, 'local') then
  print 'Warn: no `local.lua` file'
end

-- Install plugins
vim.pack.add {
  -- Completion
  -- Using a release tag makes blink automatically download pre-built binaries
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.x' },
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.x' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },

  -- LSP
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/rachartier/tiny-code-action.nvim' },

  -- Other
  { src = 'https://github.com/HiPhish/rainbow-delimiters.nvim' },
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  { src = 'https://github.com/chrisgrieser/nvim-spider' },
  { src = 'https://github.com/crispgm/nvim-tabline' },
  { src = 'https://github.com/dhruvasagar/vim-pairify' },
  { src = 'https://github.com/folke/todo-comments.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/hat0uma/csvview.nvim' },
  { src = 'https://github.com/kwkarlwang/bufjump.nvim' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  { src = 'https://github.com/monaqa/dial.nvim' },
  { src = 'https://github.com/nmac427/guess-indent.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },

  -- And some that don't need any setup:

  -- Undo closing a split with `<C-w>u`
  { src = 'https://github.com/AndrewRadev/undoquit.vim' },
}

-- Install additional plugins if `work_profile` is enabled
if vim.g.work_profile then
  vim.pack.add {
    'https://github.com/zbirenbaum/copilot.lua',
    'https://github.com/fang2hou/blink-copilot',
  }
end

-- Make 'mini.icons' pretend to be 'nvim-web-devicons'
package.preload['nvim-web-devicons'] = function()
  require('mini.icons').mock_nvim_web_devicons()
  return package.loaded['nvim-web-devicons']
end

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out =
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run :Lazy
require('lazy').setup('plugins', {
  change_detection = {
    notify = false, -- Disable annoying pop-up whenever you change any config files.
  },
  performance = {
    -- Keep `packpath` and `runtimepath` intact for built-in `vim.pack` plugins.
    reset_packpath = false,
    rtp = { reset = false },
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Load keymaps after lazy so I can add binds for plugins if I want to
require 'keymaps'
require 'usercmds'
require 'autocmds'
