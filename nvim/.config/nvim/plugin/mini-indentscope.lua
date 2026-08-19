-- Visualize and work with indent scope
require('mini.indentscope').setup {
  draw = {
    delay = 0,
    animation = require('mini.indentscope').gen_animation.linear {
      easing = 'out',
      duration = 10,
      unit = 'step',
    },
  },
  mappings = {
    -- I don't find any of the mappings useful
    object_scope = '',
    object_scope_with_border = '',
    -- I prefer the mini.bracketed mappings for indentation
    goto_top = '',
    goto_bottom = '',
  },
  options = {
    -- Ignore cursor column when calculating current scope
    -- indent_at_cursor = false,
    -- Use inner scope when used on a scope border (e.g. function header)
    try_as_border = true,
  },
  -- Use the same symbol as 'indent-blankline.nvim'
  symbol = '▎',
}

-- Disable indentscope in certain buffers
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('mini', { clear = true }),
  pattern = {
    'grug-far',
    'help',
    'markdown',
    'mason',
    'oil_preview',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- Disable indentscope in terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'mini',
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
