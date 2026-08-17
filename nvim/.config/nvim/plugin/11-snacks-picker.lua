-- Set up picker
local picker = Snacks.picker

-- Add shorthands for some longer picker invocations
local errors_buffer = function()
  picker.diagnostics_buffer { severity = vim.diagnostic.severity.ERROR }
end
local errors = function()
  picker.diagnostics { severity = vim.diagnostic.severity.ERROR }
end
local directories = function()
  picker.files {
    cmd = 'fd',
    args = { '--type', 'd' },
    transform = function(item)
      -- Filter out non-directories since the it always adds `--type f` -_-
      return vim.fn.isdirectory(item.file) == 1
    end,
    layout = { hidden = { 'preview' } },
    -- TODO: Add keybind to chain into another search?
  }
end
local local_files = function()
  picker.files { cwd = vim.fn.expand '%:p:h' }
end
local local_grep = function()
  picker.grep { cwd = vim.fn.expand '%:p:h' }
end
local grep_WORD = function()
  picker.grep_word {
    search = function(p)
      return p.visual and p.visual.text or vim.fn.expand '<cWORD>'
    end,
  }
end

local map = function(key, func, desc, mode)
  vim.keymap.set(mode or 'n', key, func, { desc = desc })
end

-- Set up keymaps - see `:h snacks-pickers-sources`
-- stylua: ignore
do
  -- Misc
  map('<leader><leader>', picker.buffers,    'Switch buffers')
  map('<leader>/',        picker.smart,      'Smart finder (buffers, recents, files)')
  map('<leader>gs',       picker.git_status, 'Status')
  map('<leader>fr',       picker.resume,     'Resume')
  map('<leader>sr',       picker.resume,     'Resume')

  -- Search Help
  map('<leader>hh', picker.help,         'Help')
  map('<leader>hc', picker.commands,     'Commands')
  map('<leader>hk', picker.keymaps,      'Keybinds')
  map('<leader>hp', picker.pickers,      'Pickers')
  map('<leader>ht', picker.colorschemes, 'Themes')
  map('<leader>hi', picker.icons,        'Icons')

  -- Find files (or directories!)
  map('<leader>ff', picker.files,  'Global (all files)')
  map('<leader>fl', local_files,   'Local (current dir)')
  map('<leader>fo', picker.recent, 'Oldfiles (recent files)')
  map('<leader>fd', directories,   'Directories')
  map('<leader>fs', picker.smart,  'Smart')

  -- Search for strings (lines, contents, etc)
  map('<leader>ss', picker.grep,         'Global (all files)')
  map('<leader>sl', local_grep,          'Local (current dir)')
  map('<leader>st', picker.lines,        'This buffer')
  map('<leader>sb', picker.grep_buffers, 'All buffers')

  -- Search for diagnostics/errors
  map('<leader>sd', picker.diagnostics_buffer, 'Diagnostics (buffer)')
  map('<leader>sD', picker.diagnostics,        'Diagnostics (global)')
  map('<leader>se', errors_buffer,             'Errors (buffer)')
  map('<leader>sE', errors,                    'Errors (global)')

  -- Search for current word/visual selection
  map('<leader>sw', picker.grep_word, 'Current word', { 'n', 'x' })
  map('<leader>sW', grep_WORD,        'Current WORD', { 'n', 'x' })

  -- Search/Find within my nvim config
  local config = vim.fn.stdpath 'config'
  map('<leader>fv', function() picker.files { cwd = config } end, 'Vim config')
  map('<leader>sv', function() picker.grep  { cwd = config } end, 'Vim config')

  -- Search/Find within my notes directory
  map('<leader>fn', function() picker.files { cwd = '~/notes' } end, 'Notes')
  map('<leader>sn', function() picker.grep  { cwd = '~/notes' } end, 'Notes')
end
