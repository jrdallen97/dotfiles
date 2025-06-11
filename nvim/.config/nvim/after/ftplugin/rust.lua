local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'Rust: ' .. desc, buffer = true })
end

-- Override run commands for rust scripts
map('<leader>rr', ':w<cr>:!rust-script %:p<cr>', '[RR]un current file (shebang)')
map('<leader>rt', ':w<cr>:!time rust-script %:p<cr>', '[R]un & [T]ime current file (shebang)')

-- Add some extra bindings for running with cargo
map('<leader>rf', ':w<cr>:!cargo run -r --bin %:t:r<cr>', '[R]un [F]ile (with cargo)')
map('<leader>rd', ':w<cr>:!cargo run -r --bin %:h:t<cr>', '[R]un [D]irectory (with cargo)')
map('<leader>rtf', ':w<cr>:!time cargo run -r --bin %:t:r<cr>', '[R]un & [T]ime [F]ile (with cargo)')
map('<leader>rtd', ':w<cr>:!time cargo run -r --bin %:h:t<cr>', '[R]un & [T]ime [D]irectory (with cargo)')
