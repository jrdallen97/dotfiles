-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end

local setloclist_errors = function()
  vim.diagnostic.setloclist { severity = { min = vim.diagnostic.severity.ERROR } }
end
local setqflist_errors = function()
  vim.diagnostic.setqflist { severity = { min = vim.diagnostic.severity.ERROR } }
end

-- stylua: ignore start

-- Jump to vim settings
map('<leader>ev', ':tabe ~/.config/nvim/lua<CR>',                '[E]dit [V]im settings')
map('<leader>ec', ':tabe ~/.config/nvim/CHEATSHEET.md<CR>',      '[E]dit [C]heatsheet')
map('<leader>es', ':tabe ~/.config/nvim/spell/en.utf-8.add<CR>', '[E]dit [S]pellfile')

if vim.g.work_profile then
  map('<leader>eg', ':tabe ~/code/CloudExperiments/scratch/main.go<CR>', '[E]dit [G]o scratch')
end

-- Easily run executable files
map('<leader>rs',  ':w<CR>:!%:p<CR>',      'Shebang: Run file')
map('<leader>rts', ':w<CR>:!time %:p<CR>', 'Shebang: Time file')

-- Diagnostic keymaps
map('<leader>l', setloclist_errors,         'Open diagnostic [L]ocation list (errors only)')
map('<leader>L', vim.diagnostic.setloclist, 'Open diagnostic [L]ocation list (all diagnostics)')
map('<leader>q', setqflist_errors,          'Open diagnostic [Q]uickfix list (errors only)')
map('<leader>Q', vim.diagnostic.setqflist,  'Open diagnostic [Q]uickfix list (all diagnostics)')

-- Clear highlights on search when pressing <Esc> in normal mode
map('<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode with a sane shortcut. Otherwise, you normally need to press <C-\><C-n>.
-- NOTE: This won't work in all terminal emulators/tmux/etc.
map('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode', 't')

-- Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('<C-h>', '<C-w>h', 'Go to the left window')
map('<C-l>', '<C-w>l', 'Go to the right window')
map('<C-j>', '<C-w>j', 'Go to the lower window')
map('<C-k>', '<C-w>k', 'Go to the upper window')
-- Focus in on a specific file
map('<C-w>t', ':tab split<CR>', 'Duplicate window into a new tab')
map('<C-w>f', '<C-w>_<C-w>|',   'Focus window (maximise height & width)')
-- Move windows around more easily
map('<C-w><S-Left>',  '<C-w>H', 'Move window to far left')
map('<C-w><S-Down>',  '<C-w>J', 'Move window to far bottom')
map('<C-w><S-Up>',    '<C-w>K', 'Move window to far top')
map('<C-w><S-Right>', '<C-w>L', 'Move window to far right')

-- Easily switch tabs
map('<leader>1', '1gt', 'Go to tab #1')
map('<leader>2', '2gt', 'Go to tab #2')
map('<leader>3', '3gt', 'Go to tab #3')
map('<leader>4', '4gt', 'Go to tab #4')
map('<leader>5', '5gt', 'Go to tab #5')
map('<leader>6', '6gt', 'Go to tab #6')
map('<leader>7', '7gt', 'Go to tab #7')
map('<leader>8', '8gt', 'Go to tab #8')
map('<leader>9', '9gt', 'Go to tab #9')
map('<leader>0', ':tablast<cr>', 'Go to last tab')

-- Reselect after changing indentation
map('>', '>gv', 'Increase indentation & reselect', 'v')
map('<', '<gv', 'Decrease indentation & reselect', 'v')

-- stylua: ignore end

-- If foldlevel is at 99 (default), reset it with zR before running zm
vim.keymap.set('n', 'zm', function()
  return vim.o.foldlevel == 99 and 'zRzm' or 'zm'
end, { expr = true })

-- I often accidentally type `:Qa` when I mean `:qa`
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Wa', 'wa', {})
