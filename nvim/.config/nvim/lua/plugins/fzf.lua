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

      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { desc = desc })
      end

      -- Misc
      map('<leader><leader>', fzf.buffers, '[ ] Find existing buffers')
      map('<leader>/', fzf.grep_curbuf, '[/] search in current buffer')
      map('<leader>sr', fzf.resume, '[S]earch [R]esume')
      map('<leader>ss', fzf.builtin, '[S]earch [S]each commands')
      map('<leader>gs', fzf.git_status, '[Git] [S]tatus')
      -- Search within my nvim config
      map('<leader>sv', function()
        fzf.live_grep { cwd = vim.fn.stdpath 'config' }
      end, '[S]earch [V]im config')

      -- Vim stuff
      map('<leader>se', fzf.diagnostics_document, '[S]earch [E]rrors (diagnostics)')
      map('<leader>sh', fzf.helptags, '[S]earch [H]elp')
      map('<leader>sk', fzf.keymaps, '[S]earch [K]eymaps')

      -- Basic search
      map('<leader>sf', fzf.files, '[S]earch [F]iles')
      map('<leader>sg', fzf.live_grep, '[S]earch by [G]rep')
      map('<leader>so', fzf.oldfiles, '[S]earch [O]ldfiles')
      map('<leader>sd', function()
        fzf.files {
          cmd = 'fd -t=d',
          winopts = { preview = { hidden = true } },
        }
      end, '[S]earch [D]irectories')

      -- Search for current word/visual selection
      map('<leader>sw', fzf.grep_cword, '[S]earch [W]ord under cursor')
      map('<leader>sW', fzf.grep_cWORD, '[S]earch [W]ORD under cursor')
      map('<leader>s', fzf.grep_visual, '[S]earch visual selection', 'v')
    end,
  },
}
