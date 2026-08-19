local cmd = vim.api.nvim_create_user_command

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
  MiniSessions.write('Session.vim', { force = true })
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
