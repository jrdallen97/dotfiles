local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'iTerm2 Default'
config.colors = {
  cursor_fg = '#000000',
  cursor_bg = '#ffffff',
}

-- Fix macOS titlebar/transparency issues
config.window_decorations = 'MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR|TITLE|RESIZE'

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

-- Work-specific settings
if wezterm.target_triple == 'aarch64-apple-darwin' then
  wezterm.on('gui-startup', function(_)
    -- Open preset tabs
    local first_tab, notes_pane, window = wezterm.mux.spawn_window { cwd = wezterm.home_dir .. '/notes' }
    for _ = 1, 3 do
      window:spawn_tab { cwd = wezterm.home_dir .. '/code/CloudExperiments/' }
    end
    window:spawn_tab { cwd = wezterm.home_dir .. '/dotfiles/' }
    first_tab:activate()

    -- If my home monitor is detected, also resize & position the window how I like it
    local screens = wezterm.gui.screens()
    local screen = screens.by_name['VG27A']
    if screen then
      local gui_window = window:gui_window()
      local width, height = 2250, 1100
      gui_window:set_inner_size(width, height)
      wezterm.time.call_after(0.2, function()
        -- set_position uses the built-in display's scale, so we need to manually offset it for regular monitors
        gui_window:set_position(2 * (screen.x + screen.width - width), screens.main.height - 2 * (screen.y + height))
      end)
    end

    -- Open my notes
    notes_pane:send_text './weekly.sh\n'
  end)
end

-- Windows-specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.font_size = 12
  config.default_domain = 'WSL:Ubuntu'

  config.initial_rows = 40
  config.initial_cols = 100
end

return config
