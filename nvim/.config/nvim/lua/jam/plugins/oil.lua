return {
  -- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      -- Replace netrw
      default_file_explorer = true,
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,

      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
    }

    -- Mimic the vim-vinegar method of navigating to the parent directory of a file
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
