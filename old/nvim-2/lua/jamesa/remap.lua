vim.g.mapleader = ' '

-- Run files
vim.keymap.set('n', '<leader>rr', ':w<cr>:!%:p<cr>', { desc = '[r]un current file (shebang)' })
vim.keymap.set('n', '<leader>rt', ':w<cr>:!time %:p<cr>', { desc = '[r]un & [t]ime current file (shebang)' })

-- Terminal mode
vim.keymap.set('t', '<leader><esc>', '<c-\\><c-n>', { desc = 'escape from terminal' })

-- Jump to vim settings
vim.keymap.set('n', '<leader>ev', ':tabe ~/.config/nvim<cr>', { desc = '[e]dit [v]im settings' })
vim.keymap.set('n', '<leader>ec', ':tabe ~/.config/nvim/CHEATSHEET.md<cr>', { desc = '[e]dit [c]heatsheet' })

-- Quick toggles
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

-- Quickfix helpers
vim.keymap.set('n', '<leader>co', ':copen<CR>', { desc = 'Open the quickfix list window' })
vim.keymap.set('n', '<leader>cc', ':cclose<CR>', { desc = 'Close the quickfix list window' })
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = 'Go to the next item on the list' })
vim.keymap.set('n', '<leader>cp', ':cprev<CR>', { desc = 'Go to the previous item on the list' })
vim.keymap.set('n', '<leader>cf', ':cfirst<CR>', { desc = 'Go to the first item on the list' })
vim.keymap.set('n', '<leader>cl', ':clast<CR>', { desc = 'Go to the last item on the list' })
