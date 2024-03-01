return {
  {
    'nvim-telescope/telescope.nvim', -- Fancy search library
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      -- Find
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find help tags' },
      { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },

      -- Search
      { '<leader>ss', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>sw', 'yiw:Telescope grep_string search=<c-r>"<cr>', desc = 'Search for current word in files' },
    },
  },
}
