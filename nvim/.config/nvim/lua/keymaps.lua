-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local set = vim.keymap.set

-- Jump to vim settings
set('n', '<leader>ev', ':tabe ~/.config/nvim/lua<cr>', { desc = '[E]dit [V]im settings' })
set('n', '<leader>ec', ':tabe ~/.config/nvim/CHEATSHEET.md<cr>', { desc = '[E]dit [C]heatsheet' })

-- Notes
set('n', '<leader>en', ':tabe ~/notes/<cr>', { desc = '[E]dit [N]otes' })
-- set(
--   'n',
--   '<leader>ed',
--   -- Open today's daily note, open TODOs in a split, change back to the first split.
--   ':exec "tabe ~/notes/diary/".strftime("%F").".md"<cr>:sp ~/notes/diary/TODO.md<cr><C-w><C-k>',
--   { desc = '[E]dit [D]aily note' }
-- )
set('n', '<leader>et', ':tabe ~/notes/diary/TODO.md<cr>', { desc = '[E]dit [T]odo list' })

-- Easily run executable files
set('n', '<leader>rr', ':w<cr>:!%:p<cr>', { desc = '[RR]un current file (shebang)' })
set('n', '<leader>rt', ':w<cr>:!time %:p<cr>', { desc = '[R]un & [T]ime current file (shebang)' })

-- Diagnostic keymaps
set('n', '<leader>L', vim.diagnostic.setloclist, { desc = 'Open diagnostic [L]ocation list (all diagnostics)' })
set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list (all diagnostics)' })
-- Less busy diagnostic keymaps
set('n', '<leader>l', function()
  vim.diagnostic.setloclist { severity = { min = vim.diagnostic.severity.ERROR } }
end, { desc = 'Open diagnostic [L]ocation list (errors only)' })
set('n', '<leader>q', function()
  vim.diagnostic.setqflist { severity = { min = vim.diagnostic.severity.ERROR } }
end, { desc = 'Open diagnostic [Q]uickfix list (errors only)' })

-- Clear highlights on search when pressing <Esc> in normal mode
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Quick toggles
-- set('n', '<leader>tl', ':set list!<cr>', { desc = '[T]oggle [L]ist' })
set('n', '<leader>tw', ':set wrap!<cr>', { desc = '[T]oggle [W]rap' })

-- Move lines up & down easily
-- E.g. ":m '>+1<CR>gv" = Move selection down, reindent & reselect
-- set('v', 'J', ":m '>+1<CR>gv", { desc = 'Move selection down' })
-- set('v', 'K', ":m '<-2<CR>gv", { desc = 'Move selection up' })
-- set('v', '<S-Down>', ":m '>+1<CR>gv", { desc = 'Move selection down' })
-- set('v', '<S-Up>', ":m '<-2<CR>gv", { desc = 'Move selection up' })

-- Reselect after changing indentation
set('v', '>', '>gv', { desc = 'Increase indentation & reselect' })
set('v', '<', '<gv', { desc = 'Decrease indentation & reselect' })
set('v', '<S-Right>', '>gv', { desc = 'Increase indentation & reselect' })
set('v', '<S-Left>', '<gv', { desc = 'Decrease indentation & reselect' })

-- If foldlevel is at 99 (default), reset it with zR before running zm
set('n', 'zm', function()
  if vim.o.foldlevel == 99 then
    return 'zRzm'
  end
  return 'zm'
end, { expr = true })

-- Easily switch to a dark colorscheme
vim.api.nvim_create_user_command('Dark', function()
  vim.cmd.colorscheme 'catppuccin'
  vim.o.bg = 'dark'
end, { desc = 'Switch to dark colorscheme' })

-- Easily switch to a light colorscheme
vim.api.nvim_create_user_command('Light', function()
  vim.cmd.colorscheme 'everforest'
  vim.o.bg = 'light'
end, { desc = 'Switch to light colorscheme' })
