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

      -- stylua: ignore start

      -- Misc
      map('<leader><leader>', fzf.buffers,     '[ ] Find existing buffers')
      map('<leader>/',        fzf.grep_curbuf, '[/] search in current buffer')
      map('<leader>gs',       fzf.git_status,  '[G]it [S]tatus')
      map('<leader>sr',       fzf.resume,      '[S]earch [R]esume')
      map('<leader>fr',       fzf.resume,      '[F]ind [R]esume')

      -- [F]ind files (or directories!)
      map('<leader>ff', fzf.files,    '[F]ind [F]iles')
      map('<leader>fo', fzf.oldfiles, '[F]ind [O]ldfiles')
      map('<leader>fd', function()
        fzf.files {
          cmd = 'fd -t=d',
          winopts = { preview = { hidden = true } },
        }
      end, '[F]ind [D]irectories')

      -- [S]earch for strings (lines, contents, etc)
      map('<leader>ss', fzf.live_grep, '[S]earch for [S]tring')
      map('<leader>sg', fzf.live_grep, '[S]earch by [G]rep')
      map('<leader>sb', fzf.lines,     '[S]earch in open [B]uffers')
      map('<leader>sk', fzf.keymaps,   '[S]earch for [K]eymaps')
      map('<leader>sh', fzf.helptags,  '[S]earch [H]elp')
      map('<leader>sc', fzf.builtin,   '[S]earch search [C]ommands')
      map('<leader>se', fzf.diagnostics_document, '[S]earch [E]rrors (diagnostics)')

      -- Search for current word/visual selection
      map('<leader>sw', fzf.grep_cword,  '[S]earch [W]ord under cursor')
      map('<leader>sW', fzf.grep_cWORD,  '[S]earch [W]ORD under cursor')
      map('<leader>s',  fzf.grep_visual, '[S]earch visual selection', 'v')

      -- Search within my nvim config
      map('<leader>fv', function() fzf.files { cwd = vim.fn.stdpath 'config' } end,     '[F]ind [V]im config')
      map('<leader>sv', function() fzf.live_grep { cwd = vim.fn.stdpath 'config' } end, '[S]earch [V]im config')

      -- Search within my notes directory
      map('<leader>fn', function() fzf.files { cwd = '~/notes' } end,     '[F]ind [N]otes')
      map('<leader>sn', function() fzf.live_grep { cwd = '~/notes' } end, '[S]earch [N]otes')

      -- stylua: ignore end
    end,
  },
}
