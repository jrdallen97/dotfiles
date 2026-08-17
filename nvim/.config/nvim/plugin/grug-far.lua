-- Grug find! Grug replace! Grug happy!
require('grug-far').setup {
  -- Don't leave behind a buffer
  transient = true,

  -- Open in a new tab
  windowCreationCommand = 'tab split',
}
