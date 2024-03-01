vim.keymap.set('n', '/', function()
  require('telescope.builtin').find_files( { cwd = vim.b.netrw_curdir } )
end, { buffer = true, desc = 'foo' })
