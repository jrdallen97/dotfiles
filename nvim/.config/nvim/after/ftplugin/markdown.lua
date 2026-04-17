-- Enable spellcheck
vim.opt_local.spell = true
-- Don't check for proper capitalisation
vim.opt_local.spellcapcheck = ''

-- Disable copilot
vim.b.disable_autosuggestions = true

-- Override default indentation
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
