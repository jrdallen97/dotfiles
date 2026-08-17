-- Set up toggle
-- stylua: ignore
do
  -- Simple toggles
  Snacks.toggle.option('wrap' ):map '<leader>tw'
  Snacks.toggle.option('spell'):map '<leader>ts'
  Snacks.toggle.diagnostics(  ):map '<leader>td'

  -- Toggle conceallevel (use `:set cole=` for values other than 2)
  Snacks.toggle.new({
    name = 'conceal',
    get = function()        return vim.o.conceallevel ~= 0          end,
    set = function(enabled) vim.o.conceallevel = enabled and 2 or 0 end,
  }):map '<leader>tc'
  -- Toggle ruler (use `:set cc=` for values other than 100)
  Snacks.toggle.new({
    name = 'ruler',
    get = function()        return vim.o.colorcolumn ~= ''                     end,
    set = function(enabled) vim.o.colorcolumn = enabled and '80,100,120' or '' end,
  }):map '<leader>tr'

  -- Easily switch between light & dark mode
  Snacks.toggle.new({
    name = 'light mode',
    get = function() return vim.o.bg == 'light' end,
    set = function(enabled)
      vim.cmd.colorscheme(enabled and vim.g.light_scheme or vim.g.dark_scheme)
      vim.o.bg = enabled and 'light' or 'dark'
    end,
  }):map '<leader>tl'

  -- Helper for disable toggles
  local disable = function(name, var, buffer)
    local v = buffer and vim.b or vim.g
    return Snacks.toggle.new({
      name = name .. (buffer and ' (buffer)' or ' (global)'),
      get = function()         return not v[var]     end,
      set = function(disabled) v[var] = not disabled end,
    })
  end

  -- Auto-format
  disable('autoformat', 'disable_autoformat', true ):map '<leader>tf'
  disable('autoformat', 'disable_autoformat', false):map '<leader>tF'

  -- Autosuggestions
  disable('autosuggestions', 'disable_autosuggestions', true ):map '<leader>ta'
  disable('autosuggestions', 'disable_autosuggestions', false):map '<leader>tA'
end
