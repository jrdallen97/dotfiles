-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local function map(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end

local function setloclist_errors()
  vim.diagnostic.setloclist { severity = { min = vim.diagnostic.severity.ERROR } }
end
local function setqflist_errors()
  vim.diagnostic.setqflist { severity = { min = vim.diagnostic.severity.ERROR } }
end

-- stylua: ignore start

-- Jump to vim settings
map('<leader>ev', ':tabe ~/.config/nvim/lua<CR>',                'Vim settings')
map('<leader>ec', ':tabe ~/.config/nvim/CHEATSHEET.md<CR>',      'Cheatsheet')
map('<leader>es', ':tabe ~/.config/nvim/spell/en.utf-8.add<CR>', 'Spellfile')

if vim.g.work_profile then
  map('<leader>eg', ':tabe ~/code/CloudExperiments/scratch/main.go<CR>', 'Go scratch file')
end

-- Easily run executable files
map('<leader>rs',  ':w<CR>:!%:p<CR>',      'Shebang: Run file')
map('<leader>rts', ':w<CR>:!time %:p<CR>', 'Shebang: Time file')

-- Diagnostic keymaps
map('<leader>l', setloclist_errors,         'Send errors to loclist')
map('<leader>L', vim.diagnostic.setloclist, 'Send all diagnostics to loclist')
map('<leader>q', setqflist_errors,          'Send errors to qflist')
map('<leader>Q', vim.diagnostic.setqflist,  'Send all diagnostics to qflist')

-- Clear search highlights when pressing <Esc> in normal mode
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

-- Quickfix helpers
map('<leader>co', ':copen<CR>',  'Open the quickfix list window')
map('<leader>cc', ':cclose<CR>', 'Close the quickfix list window')
map('<leader>cn', ':cnext<CR>',  'Go to the next item on the list')
map('<leader>cp', ':cprev<CR>',  'Go to the previous item on the list')
map('<leader>cf', ':cfirst<CR>', 'Go to the first item on the list')
map('<leader>cl', ':clast<CR>',  'Go to the last item on the list')

-- stylua: ignore end

-- If foldlevel is at 99 (default), reset it with zR before running zm
vim.keymap.set('n', 'zm', function()
  return vim.o.foldlevel == 99 and 'zRzm' or 'zm'
end, { expr = true })

-- I often accidentally type `:Qa` when I mean `:qa`
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Wa', 'wa', {})
