-- Reverse string & flip paired brackets
local mirror = function(s)
  s = s:reverse()
  local chars = {
    ['%('] = ')',
    ['%['] = ']',
    ['%{'] = '}',
    ['%<'] = '>',
  }
  for a, b in pairs(chars) do
    s = s:gsub(a, b)
  end
  return s
end

return {
  -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  lazy = false,
  priority = 90,
  config = function()
    local map = vim.keymap.set
    local cmd = vim.api.nvim_create_user_command

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require('mini.surround').setup {
      -- Override mappings to be more like tpope/vim-surround
      -- The defaults conflict with the standard vim `s` (remove char & enter insert mode)
      mappings = {
        add = 'ss', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        replace = 'cs', -- Replace surrounding

        -- Turn off the bindings I never use
        find = '', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = '', -- Highlight surrounding
        suffix_last = '', -- Suffix to search with "prev" method
        suffix_next = '', -- Suffix to search with "next" method
      },
      custom_surroundings = {
        -- Allow generic string surrounds
        s = {
          input = function()
            local s = MiniSurround.user_input 'Enter surrounding string'
            if s and s ~= '' then
              return { vim.pesc(s) .. '().-()' .. vim.pesc(s) }
            end
          end,
          output = function()
            local s = MiniSurround.user_input 'Enter surrounding string'
            if s and s ~= '' then
              return { left = s, right = s }
            end
          end,
        },
        -- Allow generic mirrored string surrounds
        m = {
          input = function()
            local s = MiniSurround.user_input 'Enter left string (will be mirrored to right)'
            if s and s ~= '' then
              return { vim.pesc(s) .. '().-()' .. vim.pesc(mirror(s)) }
            end
          end,
          output = function()
            local s = MiniSurround.user_input 'Enter left string (will be mirrored to right)'
            if s and s ~= '' then
              return { left = s, right = mirror(s) }
            end
          end,
        },

        -- Markdown bold
        B = {
          input = { '%*%*().-()%*%*' },
          output = { left = '**', right = '**' },
        },
        -- Markdown hyperlink
        h = {
          input = { '%[().-()%]%(.-%)' },
          output = function()
            local link = MiniSurround.user_input 'Link: '
            return { left = '[', right = '](' .. link .. ')' }
          end,
        },
      },
    }
    -- Don't change builtin `s` binding!
    vim.api.nvim_del_keymap('n', 's')

    -- Highlight and trim trailing whitespace
    require('mini.trailspace').setup()
    -- Add a command to easily trim whitespace
    cmd('TrimWhitespace', MiniTrailspace.trim, { desc = 'Trim whitespace' })

    -- Split and join arguments
    require('mini.splitjoin').setup()

    -- Move any selection in any direction
    require('mini.move').setup {
      -- stylua: ignore
      mappings = {
        -- Move visual selection
        left =  '<M-Left>',
        right = '<M-Right>',
        up =    '<M-Up>',
        down =  '<M-Down>',
      },
    }
    -- Also add normal/insert mode bindings
    -- stylua: ignore start
    local move = MiniMove.move_line
    map({'n', 'i'}, '<M-Left>',  function() move 'left'  end, { desc = 'Move current line left' })
    map({'n', 'i'}, '<M-Right>', function() move 'right' end, { desc = 'Move current line right' })
    map({'n', 'i'}, '<M-Up>',    function() move 'up'    end, { desc = 'Move current line up' })
    map({'n', 'i'}, '<M-Down>',  function() move 'down'  end, { desc = 'Move current line down' })
    -- stylua: ignore end

    -- Text edit operators (e.g. evaluate text, duplicate text)
    require('mini.operators').setup {
      -- Default map conflicts with `gx` (open URL)
      exchange = { prefix = '<leader>x' },
      -- Default map conflicts with `gr` (goto references)
      replace = { prefix = '' },
    }

    -- Go forward/backward with square brackets
    require('mini.bracketed').setup {
      -- Disable the weird ones
      treesitter = { suffix = '' },
      undo = { suffix = '' },
      yank = { suffix = '' },
    }

    -- Icon provider
    require('mini.icons').setup {
      style = vim.g.have_nerd_font and 'glyph' or 'ascii',
    }

    -- Highlight other occurrences of word under cursor
    require('mini.cursorword').setup()
    -- Don't highlight the actual word under the cursor
    vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', {})

    -- Visualize and work with indent scope
    require('mini.indentscope').setup {
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.linear {
          easing = 'out',
          duration = 10,
          unit = 'step',
        },
      },
      mappings = {
        -- I don't find any of the mappings useful
        object_scope = '',
        object_scope_with_border = '',
        -- I prefer the mini.bracketed mappings for indentation
        goto_top = '',
        goto_bottom = '',
      },
      options = {
        -- Ignore cursor column when calculating current scope
        -- indent_at_cursor = false,
        -- Use inner scope when used on a scope border (e.g. function header)
        try_as_border = true,
      },
      -- Use the same symbol as 'indent-blankline.nvim'
      symbol = '▎',
    }

    -- Fast and flexible start screen
    local starter = require 'mini.starter'
    starter.setup {
      header = '',

      -- Remove `-` so I can easily get into Oil
      query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.',

      items = {
        starter.sections.sessions(5, true),
        starter.sections.recent_files(10, true),
        starter.sections.builtin_actions(),
      },
    }
    cmd('Start', function()
      starter.open()
    end, { desc = 'Open start screen' })

    -- Session management (read, write, delete)
    require('mini.sessions').setup {
      -- Whether to read default session if Neovim opened without file arguments
      autoread = false,

      -- Whether to print session path after action
      verbose = { read = true, write = true, delete = true },
    }

    -- Save/create session
    cmd('Save', function(opts)
      MiniSessions.write(opts.fargs[1])
    end, { nargs = '?', desc = 'mini.sessions: Save/create session' })
    -- Save/create local session
    cmd('SaveLocal', function()
      MiniSessions.write('session.vim', { force = true })
    end, { nargs = 0, desc = 'mini.sessions: Save/create local session' })
    -- Load session (or delete with `<C-x>`)
    cmd('Sessions', function()
      require 'snacks.picker' {
        title = 'Sessions',
        finder = function()
          local items = {}
          for _, item in pairs(MiniSessions.detected or {}) do
            table.insert(items, {
              name = item.name,
              type = item.type,
              text = string.format('%s (%s)', item.name, item.type),
            })
          end
          table.sort(items, function(a, b)
            return a.type == b.type and a.name < b.name or a.type == 'local'
          end)
          return items
        end,
        format = 'text',
        layout = { hidden = { 'preview' } },
        confirm = function(_, item)
          MiniSessions.read(item.name)
        end,
        actions = {
          delete_session = function(picker, item)
            MiniSessions.delete(item.name)
            -- Refresh items
            picker:find { refresh = true }
          end,
        },
        win = {
          input = {
            keys = {
              ['<C-x>'] = { 'delete_session', mode = { 'n', 'i' } },
            },
          },
          list = {
            keys = {
              ['<C-x>'] = { 'delete_session', mode = { 'n', 'i' } },
            },
          },
        },
      }
    end, { nargs = 0, desc = 'mini.sessions: List sessions' })

    -- Work with diff hunks
    require('mini.diff').setup {
      mappings = {
        -- Unbind these & use custom mappings instead
        apply = '',
        reset = '',

        -- More typical textobject
        textobject = 'ih',
      },
      options = {
        -- Wrap around the end of file during hunk navigation
        wrap_goto = true,
      },
    }
    map('n', '<leader>go', MiniDiff.toggle_overlay, { desc = 'Diff Overlay' })
    -- stylua: ignore
    do
      local diff = function(action, s)
        return function()
          return string.format(s, MiniDiff.operator(action))
        end
      end
      map('n', 'ghs', diff('apply', '%sih'      ), { expr = true, remap = true, desc = 'Stage Hunk' })
      map('x', 'ghs', diff('apply', '%s'        ), { expr = true, remap = true, desc = 'Stage Selection' })
      map('n', 'ghS', diff('apply', 'go%sG<C-o>'), { expr = true, remap = true, desc = 'Stage File' })
      map('n', 'ghr', diff('reset', '%sih'      ), { expr = true, remap = true, desc = 'Restore Hunk' })
      map('x', 'ghr', diff('reset', '%s'        ), { expr = true, remap = true, desc = 'Restore Selection' })
      map('n', 'ghR', diff('reset', 'go%sG<C-o>'), { expr = true, remap = true, desc = 'Restore File' })
    end

    -- Set up terminal background synchronization
    -- (prevents black borders if terminal size isn't perfectly aligned)
    require('mini.misc').setup_termbg_sync()
  end,
  init = function()
    -- Make 'mini.icons' pretend to be 'nvim-web-devicons'
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end

    -- Disable indentscope in certain buffers
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('mini', { clear = true }),
      pattern = {
        'grug-far',
        'help',
        'lazy',
        'markdown',
        'mason',
        'neo-tree',
        'trouble',
        'Trouble',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    -- Disable indentscope in terminal buffers
    vim.api.nvim_create_autocmd('TermOpen', {
      group = 'mini',
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    -- Reset `]c` keymap in diff buffers
    vim.api.nvim_create_autocmd({ 'OptionSet', 'UIEnter' }, {
      group = 'mini',
      callback = function()
        if vim.wo.diff then
          vim.keymap.set('n', '[c', '[c', { buffer = true, remap = true })
          vim.keymap.set('n', ']c', ']c', { buffer = true, remap = true })
        end
      end,
    })
  end,
}
