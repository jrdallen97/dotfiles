local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'iTerm2 Default'
config.colors = {
  cursor_fg = '#000000',
  cursor_bg = '#ffffff',
}

-- Icons look better using the built-in fallback nerd font rather than an actual patched nerd font (idk why)
config.font = wezterm.font 'Hack'
config.font_size = 15
config.adjust_window_size_when_changing_font_size = false

-- Make the cursor use inverted colours for better visibility (particularly for light colourschemes)
-- config.force_reverse_video_cursor = true

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

-- Nightly-only features
if wezterm.version > '20240203-110809-5046fc22' then
  config.show_close_tab_button_in_tabs = false
end

-- By default wezterm uses a weird fake fullscreen mode
config.native_macos_fullscreen_mode = true

-- Spawn new tab to the right of current tab (rather than at the end)
-- https://github.com/wez/wezterm/issues/909
local new_tab = wezterm.action_callback(function(win, pane)
  local mux_win = win:mux_window()
  for _, item in ipairs(mux_win:tabs_with_info()) do
    if item.is_active then
      mux_win:spawn_tab {}
      win:perform_action(wezterm.action.MoveTab(item.index + 1), pane)
      return
    end
  end
end)

-- Bind custom keybinds
config.keys = {
  { key = 't', mods = 'CMD', action = new_tab },
  { key = 't', mods = 'CTRL|SHIFT', action = new_tab },
}

-- Windows-specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.font_size = 12
  config.default_domain = 'WSL:Ubuntu'

  config.initial_rows = 40
  config.initial_cols = 100
end

return config
