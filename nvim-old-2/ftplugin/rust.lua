-- Override run commands for rust scripts
vim.keymap.set('n', '<leader>rr', ':w<cr>:!rust-script %:p<cr>', { desc = '[r]un current file (shebang)', buffer = true })
vim.keymap.set('n', '<leader>rt', ':w<cr>:!time rust-script %:p<cr>', { desc = '[r]un & [t]ime current file (shebang)', buffer = true })

-- Add some extra bindings for running with cargo
vim.keymap.set('n', '<leader>rf', ':w<cr>:!cargo run -r --bin %:t:r<cr>', { desc = '[r]un [f]ile (with cargo)', buffer = true })
vim.keymap.set('n', '<leader>rd', ':w<cr>:!cargo run -r --bin %:h:t<cr>', { desc = '[r]un [d]irectory (with cargo)', buffer = true })
vim.keymap.set('n', '<leader>rtf', ':w<cr>:!time cargo run -r --bin %:t:r<cr>', { desc = '[r]un & [t]ime [f]ile (with cargo)', buffer = true })
vim.keymap.set('n', '<leader>rtd', ':w<cr>:!time cargo run -r --bin %:h:t<cr>', { desc = '[r]un & [t]ime [d]irectory (with cargo)', buffer = true })
