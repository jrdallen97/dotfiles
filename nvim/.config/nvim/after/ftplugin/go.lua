vim.bo.autoindent = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = false

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc, buffer = true })
end

-- stylua: ignore start

-- Override run commands for go scripts
map('<leader>rr', ':w<cr>:!go run %<cr>',      'Go: Run current file')
map('<leader>rt', ':w<cr>:!time go run %<cr>', 'Go: Time current file')
