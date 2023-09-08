return {
  { 'tpope/vim-vinegar' }, -- Improvements to netrw
  {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    config = function()
      -- Disable sleuth for Go - it'll always be tabs!
      vim.g.sleuth_go_heuristics = 0
    end,
  },
  {
    'catppuccin/nvim', -- Colorscheme
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({ flavour = 'macchiato' })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true
        }
      })
    end
  },
  {
    'lewis6991/gitsigns.nvim', -- Git changed lines in gutter
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    'numToStr/Comment.nvim', -- Smart and Powerful commenting plugin
    config = true,
  },
}
