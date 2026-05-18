-- Enable spellcheck
vim.opt_local.spell = true
-- Don't check for proper capitalisation
vim.opt_local.spellcapcheck = ''

-- Disable copilot
vim.b.disable_autosuggestions = true

-- Override default indentation
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.textwidth = 0

-- Disable mini.move's auto-indentation bc it does weird stuff with lists
vim.b.minimove_config = { options = { reindent_linewise = false } }
