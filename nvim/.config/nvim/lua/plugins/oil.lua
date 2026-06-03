local detail = false

return {
  {
    -- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
    'stevearc/oil.nvim',
    config = function()
      local oil = require 'oil'

      -- Override default select to prevent it from following symlinks
      local function select(desc, cmd, fallback_opts)
        return {
          desc = desc,
          callback = function()
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()

            if entry and entry.type == 'link' and dir then
              return vim.cmd[cmd](vim.fn.fnameescape(dir .. entry.name))
            end

            oil.select(fallback_opts)
          end,
        }
      end

      oil.setup {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        constrain_cursor = 'name',

        view_options = {
          show_hidden = true,

          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, _)
            -- Hide '..' because it's annoying to have to move the cursor down every time I change directory
            return name == '..'
          end,
        },

        lsp_file_methods = {
          -- Autosave buffers that are updated with LSP willRenameFiles, unless they are already modified
          autosave_changes = 'unmodified',
        },

        keymaps = {
          ['<CR>'] = select('Open entry', 'edit'),
          ['<C-s>'] = select('Open entry in vertical split', 'vsplit', { vertical = true }),
          ['<C-h>'] = select('Open entry in horizontal split', 'split', { horizontal = true }),
          ['<C-t>'] = select('Open entry in new tab', 'tabedit', { tab = true }),
          ['<M-h>'] = { 'actions.toggle_hidden', desc = 'Toggle hidden files' },
          ['<C-p>'] = false, -- Conflicts with previous buffer keybind

          -- Quick toggle to show file details (:h oil-columns)
          ['<M-d>'] = {
            desc = 'Toggle file detail view',
            callback = function()
              detail = not detail
              oil.set_columns(detail and { 'mtime', 'permissions', 'size', 'icon' } or { 'icon' })
            end,
          },

          -- Helpers to call pickers from the current directory
          ['<leader>fl'] = {
            desc = 'Local (current directory)',
            callback = function()
              require('snacks.picker').files { cwd = oil.get_current_dir() }
            end,
          },
          ['<leader>sl'] = {
            desc = 'Local (current directory)',
            callback = function()
              require('snacks.picker').grep { cwd = oil.get_current_dir() }
            end,
          },
        },
      }

      -- Mimic the vim-vinegar method of navigating to the parent directory of a file
      vim.keymap.set('n', '-', oil.open, { desc = 'Open parent directory' })
    end,
  },
}
