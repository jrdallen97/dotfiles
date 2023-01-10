local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[f]ind files tracked by [g]it' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<leader>fv', function()
  builtin.find_files( { cwd = vim.fn.stdpath('config') } )
end, { desc = '[f]ind [v]im config files' })

vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = '[f]ind [s]tring (grep)' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[f]ind current [w]ord' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[f]ind [r]ecently opened files' })

vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]elp' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[f]ind [k]eymaps' })
vim.keymap.set('n', '<leader>f:', builtin.commands, { desc = '[f]ind [:]command' })

vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'find existing buffers' })
