-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end

-- Jump to vim settings
map('<leader>ev', ':tabe ~/.config/nvim/lua<CR>', '[E]dit [V]im settings')
map('<leader>ec', ':tabe ~/.config/nvim/CHEATSHEET.md<CR>', '[E]dit [C]heatsheet')

-- Notes
map('<leader>en', ':tabe ~/notes/<CR>', '[E]dit [N]otes')
-- map(
--   '<leader>ed',
--   -- Open today's daily note, open TODOs in a split, change back to the first split.
--   ':exec "tabe ~/notes/diary/".strftime("%F").".md"<CR>:sp ~/notes/diary/TODO.md<CR><C-w><C-k>',
--   '[E]dit [D]aily note'
-- )
map('<leader>et', ':tabe ~/notes/diary/TODO.md<CR>', '[E]dit [T]odo list')

-- Easily run executable files
map('<leader>rr', ':w<CR>:!%:p<CR>', '[RR]un current file (shebang)')
map('<leader>rt', ':w<CR>:!time %:p<CR>', '[R]un & [T]ime current file (shebang)')

-- Diagnostic keymaps
map('<leader>L', vim.diagnostic.setloclist, 'Open diagnostic [L]ocation list (all diagnostics)')
map('<leader>Q', vim.diagnostic.setqflist, 'Open diagnostic [Q]uickfix list (all diagnostics)')
-- Less busy diagnostic keymaps
map('<leader>l', function()
  vim.diagnostic.setloclist { severity = { min = vim.diagnostic.severity.ERROR } }
end, 'Open diagnostic [L]ocation list (errors only)')
map('<leader>q', function()
  vim.diagnostic.setqflist { severity = { min = vim.diagnostic.severity.ERROR } }
end, 'Open diagnostic [Q]uickfix list (errors only)')

-- Clear highlights on search when pressing <Esc> in normal mode
map('<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode', 't')

-- Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')
-- A couple of bindings to focus in on a specific file
map('<C-w>t', ':tab split<CR>', 'Duplicate window into a new tab')
map('<C-w>f', '<C-w>_<C-w>|', 'Focus window (maximise height & width)')
-- Move windows around more easily
map('<C-w><S-Left>', '<C-w>H', 'Move window to far left')
map('<C-w><S-Down>', '<C-w>J', 'Move window to far bottom')
map('<C-w><S-Up>', '<C-w>K', 'Move window to far top')
map('<C-w><S-Right>', '<C-w>L', 'Move window to far right')

-- Quick toggles
-- map('<leader>tl', ':set list!<CR>', '[T]oggle [L]ist' )
map('<leader>tw', ':set wrap!<CR>', '[T]oggle [W]rap')

-- Move lines up & down easily
-- E.g. ":m '>+1<CR>gv" = Move selection down, reindent & reselect
-- map('<S-Down>', ":m '>+1<CR>gv", 'Move selection down', 'v' )
-- map('<S-Up>', ":m '<-2<CR>gv", 'Move selection up', 'v' )

-- Reselect after changing indentation
map('>', '>gv', 'Increase indentation & reselect', 'v')
map('<', '<gv', 'Decrease indentation & reselect', 'v')
-- map('<S-Right>', '>gv', 'Increase indentation & reselect', 'v')
-- map('<S-Left>', '<gv', 'Decrease indentation & reselect', 'v')

-- If foldlevel is at 99 (default), reset it with zR before running zm
vim.keymap.set('n', 'zm', function()
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
  vim.cmd.colorscheme 'bamboo'
  vim.o.bg = 'light'
end, { desc = 'Switch to light colorscheme' })
