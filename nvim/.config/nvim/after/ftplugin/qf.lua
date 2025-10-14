-- Makes it possible to delete quickfix entries with `dd`
vim.keymap.set('n', 'dd', function()
  -- Try to work out whether we're in a location list or the quickfix list
  local is_loc = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].loclist == 1

  local items = is_loc and vim.fn.getloclist(0) or vim.fn.getqflist()
  local current_line_number = vim.fn.line '.'

  if items[current_line_number] then
    table.remove(items, current_line_number)

    if is_loc then
      vim.fn.setloclist(0, items, 'u')
    else
      vim.fn.setqflist(items, 'u')
    end

    -- Close the list when deleting the last entry
    if #items == 0 then
      if is_loc then
        vim.cmd.lclose()
      else
        vim.cmd.cclose()
      end
    else
      vim.fn.cursor(math.min(current_line_number, #items), 1)
    end
  end
end, { buffer = true, desc = 'Delete quickfix entry' })
