-- Move by subwords and skip insignificant punctuation.
local spider = require 'spider'
spider.setup {
  skipInsignificantPunctuation = true,
  subwordMovement = true,
}

-- Add keybinds behind a `,` prefix so we don't override default motions
for _, key in ipairs { 'w', 'e', 'b', 'ge' } do
  vim.keymap.set({ 'n', 'o', 'x' }, ',' .. key, function()
    spider.motion(key)
  end, { desc = 'Spider: ' .. key })
end
