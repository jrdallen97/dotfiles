-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
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

  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'tpope/vim-vinegar' -- Improvements to netrw
  use 'tpope/vim-fugitive' -- Git integration
  use 'machakann/vim-highlightedyank' -- Briefly highlights yanked text
  use 'mbbill/undotree' -- Provides an a tree view for interacting with file history
  use 'ntpeters/vim-better-whitespace' -- Highlight and remove trailing whitespace

  -- Mark git changed lines in the gutter
  --use 'airblade/vim-gitgutter'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  --use 'tpope/vim-surround'
  --use '~/.fzf'
  --use 'junegunn/fzf.vim'

  use "ellisonleao/gruvbox.nvim"

end)
