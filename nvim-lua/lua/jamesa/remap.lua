vim.g.mapleader = ' '
vim.keymap.set('n', ',', '<leader>', { remap = true }) -- Use ',' as an additional leader key

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex) -- :Ex - show current directory

-- Run files
vim.keymap.set('n', '<leader>rr', ':w<cr>:!%:p<cr>', { desc = '[r]un current file (shebang)' })
vim.keymap.set('n', '<leader>rt', ':w<cr>:!time %:p<cr>', { desc = '[r]un & [t]ime current file (shebang)' })

-- Terminal mode
vim.keymap.set('t', '<leader><esc>', '<c-\\><c-n>', { desc = 'escape from terminal' })

-- Jump to vim settings
vim.keymap.set('n', '<leader>ev', ':tabe ~/.config/nvim/lua/jamesa<cr>', { desc = '[e]dit [v]im settings' })
