return {
  {
    -- A Git wrapper so awesome, it should be illegal
    'tpope/vim-fugitive',
    lazy = false,
    -- stylua: ignore
    keys = {
      { '<leader>gg', '<cmd>tab Git<cr>',          desc = 'Fugitive' },
      { '<leader>gd', '<cmd>Gvdiffsplit<cr>',      desc = 'Diff' },
      { '<leader>gD', '<cmd>Gvdiffsplit! !~1<cr>', desc = 'Diff vs. prev commit' },
      { '<leader>gb', '<cmd>Git blame<cr>',        desc = 'Blame' },
      { '<leader>gc', '<cmd>Git commit<cr>',       desc = 'Commit' },
      { '<leader>gp', '<cmd>Git push<cr>',         desc = 'Push' },
      { '<leader>gl', '<cmd>Git pull<cr>',         desc = 'Pull' },
    },
  },
}
