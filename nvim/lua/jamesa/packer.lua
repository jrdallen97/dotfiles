-- Bootstrap packer - if not installed, it will install itself
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Automatically run PackerSync if this file is changed
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  --use 'mhartington/formatter.nvim'

  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'tpope/vim-vinegar' -- Improvements to netrw
  use 'tpope/vim-fugitive' -- Git integration
  use 'tpope/vim-surround' -- Edit surrounding characters (e.g. quotes and brackets)
  use 'machakann/vim-highlightedyank' -- Briefly highlights yanked text
  use 'ntpeters/vim-better-whitespace' -- Highlight and remove trailing whitespace

  -- Provides an a tree view for interacting with file history
  use {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  }

  -- Mark git changed lines in the gutter
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  --use '~/.fzf'
  --use 'junegunn/fzf.vim'

  use "ellisonleao/gruvbox.nvim" -- Theme

  -- If packer has just installed itself, run :PackerSync automatically
  if packer_bootstrap then
    require('packer').sync()
    print("Packer bootstrapped; relaunch nvim")
  end
end)
