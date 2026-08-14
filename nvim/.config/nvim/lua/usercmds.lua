-- [[ User Commands ]]
--  See `:help vim.api.nvim_create_user_command()`
local map = function(name, cmd, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, cmd, opts)
end

-- I often accidentally type `:Qa` when I mean `:qa`
map('Qa', 'qa')
map('Wa', 'wa')
map('Wq', 'wq')

-- For autocompletion for :Pack commands
-- stylua: ignore
local function complete_packages(match)
  return vim.iter(vim.pack.get(nil, { info = false }))
    :map(function(pack) return pack.spec.name end)
    :filter(function(name) return name:find(match, 1, true) end)
    :totable()
end

-- Helpers to make vim.pack more ergonomic
map('PackUpdate', function(info)
  vim.pack.update(#info.fargs > 0 and info.fargs or nil)
end, { desc = 'Check for package updates', nargs = '*', complete = complete_packages })
map('PackRestore', function()
  vim.pack.update(nil, { target = 'lockfile' })
end, { desc = 'Restore installed packages to versions in lockfile' })
map('PackDelete', function(info)
  vim.pack.del(info.fargs, { force = info.bang })
end, { desc = 'Delete packages', nargs = '+', bang = true, complete = complete_packages })

-- These used to be built-in to nvim-lspconfig
map('LspInfo', ':checkhealth vim.lsp')
map('LspLog', function()
  vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
end)

-- [[ Extend gx ]]

-- Get github repo from cwd
local function github_repo()
  local remote = vim.fn.systemlist({ 'git', 'ls-remote', '--get-url', 'origin' })[1] or ''
  local owner, repo = remote:match 'github%.com:(.+)/(.+)%.git$'
  return owner and ('%s/%s'):format(owner, repo) or nil
end

-- Save original vim.ui.open
local open = vim.ui.open

local overrides = {
  ['jrdallen97/notes'] = 'supersparks/CloudExperiments',
}

-- Extend gx to open GitHub PR links
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.open = function(path)
  vim.validate('path', path, 'string')

  local pr_number = string.match(path, '#(%d+)')
  if pr_number then
    local repo = github_repo()
    if repo then
      open(('https://github.com/%s/pull/%s'):format(overrides[repo] or repo, pr_number))
      return
    end
  end

  return open(path)
end

-- [[ Bigfile ]]

-- Disable slow settings/features in big files
-- NOTE: some features (e.g. `matchparen` & window settings) won't be re-enabled on switching buffers
map('Big', function()
  -- Disable treesitter-based folding
  vim.wo.foldmethod = 'indent'
  -- Disable plugins
  vim.b.miniindentscope_disable = true
end)

-- Disable even more settings/features in huge files
map('Huge', function()
  -- Don't highlight matching brackets
  vim.cmd 'NoMatchParen'
  -- Run :Big first
  vim.cmd 'Big'
  -- Disable indent guides
  vim.cmd 'IBLDisable'
  -- TODO: Disable treesitter features
  -- vim.cmd 'TSBufDisable highlight'
  -- Disable syntax highlighting
  vim.cmd.syntax 'off'
end)
