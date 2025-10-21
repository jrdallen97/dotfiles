vim.bo.autoindent = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = false

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc, buffer = true })
end

-- stylua: ignore start

-- Run
map('<leader>rr', ':w<cr>:!go run %<cr>',   'Go: Run file')
map('<leader>rd', ':w<cr>:!go run %:h<cr>', 'Go: Run directory')
-- Time
map('<leader>rtr', ':w<cr>:!time go run %<cr>',   'Go: Time file')
map('<leader>rtd', ':w<cr>:!time go run %:h<cr>', 'Go: Time directory')
-- Test
map('<leader>RR', ':w<cr>:!go test %:h<cr>',    'Go: Test directory')
map('<leader>RV', ':w<cr>:!go test %:h -v<cr>', 'Go: Test directory -v')
