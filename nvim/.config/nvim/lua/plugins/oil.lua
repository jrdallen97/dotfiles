local detail = false

return {
  {
    -- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        -- Replace netrw
        default_file_explorer = true,
        -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
        skip_confirm_for_simple_edits = true,
        -- Keep the cursor on the filename column only
        constrain_cursor = 'name',

        view_options = {
          -- Show hidden files and directories by default
          show_hidden = true,

          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, _)
            -- Hide '..' because it's annoying to have to move the cursor down every time I change directory
            return name == '..'
          end,
        },

        buf_options = {
          -- Wipe oil buffers on hide so they don't interfere with the jumplist (<C-o>, <C-p>, etc)
          bufhidden = 'wipe',
        },

        lsp_file_methods = {
          -- Autosave buffers that are updated with LSP willRenameFiles, unless they are already modified
          autosave_changes = 'unmodified',
        },

        keymaps = {
          -- Quick toggle to show file details (:h oil-columns)
          ['gd'] = {
            desc = 'Toggle file detail view',
            callback = function()
              detail = not detail
              if detail then
                require('oil').set_columns { 'mtime', 'permissions', 'size', 'icon' }
              else
                require('oil').set_columns { 'icon' }
              end
            end,
          },
          ['gh'] = {
            desc = 'Toggle hidden files',
            callback = require('oil').toggle_hidden,
          },

          -- Helpers to call fzf from the current oil directory
          ['<leader>fl'] = {
            desc = '[L]ocal (current directory)',
            callback = function()
              require('snacks.picker').files { cwd = require('oil').get_current_dir() }
            end,
          },
          ['<leader>sl'] = {
            desc = '[L]ocal (current directory)',
            callback = function()
              require('snacks.picker').grep { cwd = require('oil').get_current_dir() }
            end,
          },
        },
      }

      -- Mimic the vim-vinegar method of navigating to the parent directory of a file
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}
