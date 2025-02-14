local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "iTerm2 Default"

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14

return config
