-- [[ User Commands ]]
--  See `:help vim.api.nvim_create_user_command()`

-- I often accidentally type `:Qa` when I mean `:qa`
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Wa', 'wa', {})

-- These used to be built-in to nvim-lspconfig
vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', {})
vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
end, {})

-- [[ Extend gx ]]

-- Get github repo from cwd
local function github_repo()
  local remote = vim.fn.systemlist({ 'git', 'ls-remote', '--get-url', 'origin' })[1] or ''
  local owner, repo = remote:match 'github%.com:(.+)/(.+)%.git$'
  return owner and ('%s/%s'):format(owner, repo) or nil
end

-- Save original vim.ui.open
local open = vim.ui.open

-- Extend gx to open GitHub PR links
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.open = function(path)
  vim.validate('path', path, 'string')

  local pr_number = string.match(path, '#(%d+)')
  if pr_number then
    local repo = github_repo()
    if repo then
      if repo == 'jrdallen97/notes' then
        repo = 'supersparks/CloudExperiments'
      end

      open(('https://github.com/%s/pull/%s'):format(repo, pr_number))
      return
    end
  end

  return open(path)
end

-- [[ Bigfile ]]

-- Disable slow settings/features in big files
-- NOTE: some features (e.g. `matchparen` & window settings) won't be re-enabled on switching buffers
vim.api.nvim_create_user_command('Big', function()
  -- Disable treesitter-based folding
  vim.wo.foldmethod = 'indent'
  -- Disable plugins
  vim.b.miniindentscope_disable = true
end, {})

-- Disable even more settings/features in huge files
vim.api.nvim_create_user_command('Huge', function()
  -- Don't highlight matching brackets
  vim.cmd 'NoMatchParen'
  -- Run :Big first
  vim.cmd 'Big'
  -- Disable indent guides
  vim.cmd 'IBLDisable'
  -- Disable treesitter features
  vim.cmd 'TSBufDisable highlight'
  -- Disable syntax highlighting
  vim.cmd.syntax 'off'
end, {})
