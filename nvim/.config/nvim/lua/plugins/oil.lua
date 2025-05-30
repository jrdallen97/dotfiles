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

        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          -- Hide '..' because it's annoying to have to move the cursor down every time I change directory
          return name == '..'
        end,
      },
    }

    -- Mimic the vim-vinegar method of navigating to the parent directory of a file
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
