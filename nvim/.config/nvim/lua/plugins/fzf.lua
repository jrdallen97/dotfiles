return {
  {
    'ibhagwan/fzf-lua',
    config = function()
      local fzf = require 'fzf-lua'
      fzf.setup {
        file_icon_padding = ' ',
        winopts = {
          fullscreen = true,
        },
      }

      -- Use fzf as the default nvim select UI
      fzf.register_ui_select()

      local map = vim.keymap.set

      -- Misc
      map('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
      map('n', '<leader>/', fzf.grep_curbuf, { desc = '[/] search in current buffer' })
      map('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
      map('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]each commands' })
      map('n', '<leader>gs', fzf.git_status, { desc = '[Git] [S]tatus' })

      -- Vim stuff
      map('n', '<leader>se', fzf.diagnostics_document, { desc = '[S]earch [E]rrors (diagnostics)' })
      map('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
      map('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })

      -- Basic search
      map('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
      map('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
      map('n', '<leader>so', fzf.oldfiles, { desc = '[S]earch [O]ldfiles' })
      map('n', '<leader>sd', function()
        fzf.files {
          cmd = 'fd -t=d',
          winopts = { preview = { hidden = true } },
        }
      end, { desc = '[S]earch [D]irectories' })

      -- Search for current word/visual selection
      map('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch [W]ord under cursor' })
      map('n', '<leader>sW', fzf.grep_cWORD, { desc = '[S]earch [W]ORD under cursor' })
      map('v', '<leader>sv', fzf.grep_visual, { desc = '[S]earch [V]isual selection' })

      -- Search within my nvim config
      map('n', '<leader>sv', function()
        fzf.live_grep { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [V]im config' })
    end,
  },
}
