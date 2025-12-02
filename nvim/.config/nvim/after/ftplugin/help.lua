vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Open help in a vsplit',
  buffer = 0,
  command = 'wincmd L',
})
