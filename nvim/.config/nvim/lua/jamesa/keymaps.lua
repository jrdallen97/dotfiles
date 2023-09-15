-- Quick jump to nvim config
vim.keymap.set('n', '<leader>,', ':tabe ~/.config/nvim<cr>', { desc = 'jump to nvim config' })

-- Quick settings toggles
vim.keymap.set('n', '<leader>l', ':set list!<cr>', { desc = 'toggle [l]ist' })
vim.keymap.set('n', '<leader>w', ':set wrap!<cr>', { desc = 'toggle [w]rap' })

-- Move lines up & down easily
vim.keymap.set('v', 'J', ":m '>+1<CR>gv", { desc = 'move selection down' }) -- Move selection down, reindent & reselect
vim.keymap.set('v', 'K', ":m '<-2<CR>gv", { desc = 'move selection up' })
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv", { desc = 'move selection down' })
vim.keymap.set('v', '<S-Up>',   ":m '<-2<CR>gv", { desc = 'move selection up' })

-- Reselect after changing indentation
vim.keymap.set('v', '>', ">gv", { desc = 'increase indentation & reselect' })
vim.keymap.set('v', '<', "<gv", { desc = 'decrease indentation & reselect' })
vim.keymap.set('v', '<S-Right>', ">gv", { desc = 'increase indentation & reselect' })
vim.keymap.set('v', '<S-Left>',  "<gv", { desc = 'decrease indentation & reselect' })
