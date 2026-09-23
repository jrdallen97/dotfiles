local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'Git: ' .. desc })
end

-- A Git wrapper so awesome, it should be illegal
-- stylua: ignore
do
  map('<leader>gd', '<cmd>Gvdiffsplit<cr>',      'Diff')
  map('<leader>gD', '<cmd>Gvdiffsplit! !~1<cr>', 'Diff vs. prev commit')
  map('<leader>gb', '<cmd>Git blame<cr>',        'Blame')
  map('<leader>gp', '<cmd>Git push<cr>',         'Push')
  map('<leader>gl', '<cmd>Git pull<cr>',         'Pull')
end
