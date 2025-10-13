local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc, buffer = true })
end

-- stylua: ignore start

-- Override run commands for rust scripts
map('<leader>rr', ':w<cr>:!rust-script %:p<cr>',      'Rust: Run file')
map('<leader>rt', ':w<cr>:!time rust-script %:p<cr>', 'Rust: Time file')

-- Add some extra bindings for running with cargo
map('<leader>rf', ':w<cr>:!cargo run -r --bin %:t:r<cr>',       'Cargo: Run file')
map('<leader>rd', ':w<cr>:!cargo run -r --bin %:h:t<cr>',       'Cargo: Run directory')
map('<leader>rtf', ':w<cr>:!time cargo run -r --bin %:t:r<cr>', 'Cargo: Time file')
map('<leader>rtd', ':w<cr>:!time cargo run -r --bin %:h:t<cr>', 'Cargo: Time directory')
