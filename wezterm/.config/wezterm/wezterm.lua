local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "iTerm2 Default"

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14
config.adjust_window_size_when_changing_font_size = false

config.enable_scroll_bar = true
config.scrollback_lines = 100000

-- By default wezterm uses a weird fake fullscreen mode
config.native_macos_fullscreen_mode = true

return config
