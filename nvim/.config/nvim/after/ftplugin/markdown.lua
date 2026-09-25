-- Enable spellcheck
vim.opt_local.spell = true
-- Don't check for proper capitalisation
vim.opt_local.spellcapcheck = ''
-- Set conceal by default to make md files more readable
vim.opt_local.conceallevel = 2

-- Disable copilot
vim.b.disable_autosuggestions = true

-- Override default indentation
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.textwidth = 0

-- Autosave after running :Mtoc
vim.api.nvim_create_autocmd('CmdlineLeave', {
  buffer = 0,
  callback = function()
    if not vim.v.event.abort and vim.v.event.cmdtype == ':' and vim.fn.getcmdline() == 'Mtoc' then
      vim.schedule(vim.cmd.write)
    end
  end,
})

-- Disable mini.move's auto-indentation bc it does weird stuff with lists
vim.b.minimove_config = { options = { reindent_linewise = false } }
