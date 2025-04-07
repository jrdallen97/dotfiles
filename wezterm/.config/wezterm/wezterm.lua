local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'iTerm2 Default'

-- Icons look better using the built-in fallback nerd font rather than an actual patched nerd font (idk why)
config.font = wezterm.font 'Hack'
config.font_size = 15
config.adjust_window_size_when_changing_font_size = false

-- Reduce padding
config.window_padding = {
  left = '0',
  right = '0',
  top = '2px',
  bottom = '4px',
}
-- Snap to cell sizes
config.use_resize_increments = true

-- Disable weird font features (combining characters, ligatures)
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.enable_scroll_bar = true
config.scrollback_lines = 100000

-- By default wezterm uses a weird fake fullscreen mode
config.native_macos_fullscreen_mode = true

return config
