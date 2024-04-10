-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Jump to vim settings
vim.keymap.set('n', '<leader>ev', ':tabe ~/.config/nvim/lua/jam<cr>', { desc = '[E]dit [V]im settings' })
vim.keymap.set('n', '<leader>ec', ':tabe ~/.config/nvim/CHEATSHEET.md<cr>', { desc = '[E]dit [C]heatsheet' })

-- Notes
vim.keymap.set('n', '<leader>en', ':tabe ~/notes/<cr>', { desc = '[E]dit [N]otes' })
-- vim.keymap.set(
--   'n',
--   '<leader>ed',
--   -- Open today's daily note, open TODOs in a split, change back to the first split.
--   ':exec "tabe ~/notes/diary/".strftime("%F").".md"<cr>:sp ~/notes/diary/TODO.md<cr><C-w><C-k>',
--   { desc = '[E]dit [D]aily note' }
-- )
vim.keymap.set('n', '<leader>et', ':tabe ~/notes/diary/TODO.md<cr>', { desc = '[E]dit [T]odo list' })

-- Easily run executable files
vim.keymap.set('n', '<leader>rr', ':w<cr>:!%:p<cr>', { desc = '[RR]un current file (shebang)' })
vim.keymap.set('n', '<leader>rt', ':w<cr>:!time %:p<cr>', { desc = '[R]un & [T]ime current file (shebang)' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Go to next in quickfix list' })
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Go to previous in quickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Quick toggles
-- vim.keymap.set('n', '<leader>tl', ':set list!<cr>', { desc = '[T]oggle [L]ist' })
vim.keymap.set('n', '<leader>tw', ':set wrap!<cr>', { desc = '[T]oggle [W]rap' })

-- Move lines up & down easily
-- E.g. ":m '>+1<CR>gv" = Move selection down, reindent & reselect
vim.keymap.set('v', 'J', ":m '>+1<CR>gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv", { desc = 'Move selection up' })
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<S-Up>', ":m '<-2<CR>gv", { desc = 'Move selection up' })

-- Reselect after changing indentation
vim.keymap.set('v', '>', '>gv', { desc = 'Increase indentation & reselect' })
vim.keymap.set('v', '<', '<gv', { desc = 'Decrease indentation & reselect' })
vim.keymap.set('v', '<S-Right>', '>gv', { desc = 'Increase indentation & reselect' })
vim.keymap.set('v', '<S-Left>', '<gv', { desc = 'Decrease indentation & reselect' })
