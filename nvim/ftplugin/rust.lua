-- Override run commands for rust scripts
vim.keymap.set('n', '<leader>rr', ':w<cr>:!rust-script %:p<cr>', { desc = '[r]un current file (shebang)', buffer = true })
vim.keymap.set('n', '<leader>rt', ':w<cr>:!time rust-script %:p<cr>', { desc = '[r]un & [t]ime current file (shebang)', buffer = true })

