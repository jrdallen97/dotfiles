return {
  {
    -- A Git wrapper so awesome, it should be illegal
    'tpope/vim-fugitive',
    lazy = false,
    -- stylua: ignore
    keys = {
      { '<leader>gg', '<cmd>tab Git<cr>',    desc = 'Fugitive' },
      { '<leader>gd', '<cmd>Gdiff<cr>',      desc = 'Diff' },
      { '<leader>gD', '<cmd>Gdiff !~1<cr>',  desc = 'Diff vs. prev commit' },
      { '<leader>gb', '<cmd>Git blame<cr>',  desc = 'Blame' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Commit' },
      { '<leader>gp', '<cmd>Git push<cr>',   desc = 'Push' },
      { '<leader>gl', '<cmd>Git pull<cr>',   desc = 'Pull' },

      { 'ghS', '<cmd>silent Git add %<cr>',     desc = 'Stage buffer' },
      { 'ghR', '<cmd>silent Git restore %<cr>', desc = 'Restore buffer' },
    },
  },
}
