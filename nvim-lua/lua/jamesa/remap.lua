vim.g.mapleader = ' '
vim.keymap.set('n', ',', '<leader>', { remap = true }) -- Use ',' as an additional leader key

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex) -- :Ex - show current directory
