-- Makes it possible to delete quickfix entries with `dd`
vim.keymap.set('n', 'dd', function()
  local qf_list = vim.fn.getqflist()

  local current_line_number = vim.fn.line '.'

  if qf_list[current_line_number] then
    table.remove(qf_list, current_line_number)

    vim.fn.setqflist(qf_list, 'r')

    local new_line_number = math.min(current_line_number, #qf_list)
    vim.fn.cursor(new_line_number, 1)
  end
end, { buffer = true, desc = 'Delete quickfix entry' })
