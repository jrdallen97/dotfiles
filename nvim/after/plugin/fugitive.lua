vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[g]it [s]tatus' })
-- Note: close with <c-w><c-o>
vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { desc = '[g]it [d]iff' })
