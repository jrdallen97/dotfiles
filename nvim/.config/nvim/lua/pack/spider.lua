-- Move by subwords and skip insignificant punctuation.
vim.pack.add { 'https://github.com/chrisgrieser/nvim-spider' }

local spider = require 'spider'
spider.setup {
  skipInsignificantPunctuation = true,
  subwordMovement = true,
}

-- Add keybinds behind a `,` prefix so we don't override default motions
local function spidermap(key)
  vim.keymap.set({ 'n', 'o', 'x' }, ',' .. key, function()
    spider.motion(key)
  end, { desc = 'Spider: ' .. key })
end
spidermap 'w'
spidermap 'e'
spidermap 'b'
spidermap 'ge'
