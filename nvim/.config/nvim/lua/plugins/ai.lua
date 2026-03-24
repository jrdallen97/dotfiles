return {
  {
    -- Github Copilot integration
    'zbirenbaum/copilot.lua',
    enabled = vim.g.work_profile,
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
}
