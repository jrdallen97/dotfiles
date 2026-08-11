-- Plugins managed by the built-in vim.pack manager (migrating off lazy.nvim)
-- Each file in this directory owns its own `vim.pack.add` + config; they are
-- autoloaded below.
--
-- NOTE: lazy.nvim is configured with `performance.reset_packpath = false` (see
-- init.lua) so that `packpath` keeps the `stdpath('data')/site` dir that
-- `vim.pack` installs into.

-- Autoload every `lua/pack/*.lua` module (except this one).
local files = vim.api.nvim_get_runtime_file('lua/pack/*.lua', true)
table.sort(files)
for _, path in ipairs(files) do
  local name = path:match 'lua/pack/(.-)%.lua$'
  if name and name ~= 'init' then
    require('pack.' .. name)
  end
end
