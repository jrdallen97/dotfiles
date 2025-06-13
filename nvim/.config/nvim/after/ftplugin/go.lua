vim.bo.autoindent = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = false

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'Go: ' .. desc, buffer = true })
end

-- Override run commands for go scripts
map('<leader>rr', ':w<cr>:!go run %<cr>', '[R]un current file (go run)')
map('<leader>rt', ':w<cr>:!time go run %<cr>', '[R]un & [T]ime current file (go run)')
