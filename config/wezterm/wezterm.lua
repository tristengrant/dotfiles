local wezterm = require "wezterm"
local act = wezterm.action
local config = wezterm.config_builder()

-- GitHub Dark color palette
local colors = {
  invisibles="#2f363d"
}

-- Keybindings
config.keys = {}
-- Pane management
for _, v in ipairs({
  {"Enter", act.SplitHorizontal{domain='CurrentPaneDomain'}},
  {"w", act.CloseCurrentPane{confirm=true}},
  {"LeftArrow", act.ActivatePaneDirection'Left'},
  {"RightArrow", act.ActivatePaneDirection'Right'},
  {"UpArrow", act.ActivatePaneDirection'Up'},
  {"DownArrow", act.ActivatePaneDirection'Down'},
  {"t", act.SpawnTab'CurrentPaneDomain'},
  {"q", act.CloseCurrentTab{confirm=true}},
  {"c", act.CopyTo'ClipboardAndPrimarySelection'},
  {"v", act.PasteFrom'Clipboard'},
  {"=", act.IncreaseFontSize},
  {"-", act.DecreaseFontSize},
  {"0", act.ResetFontSize}
}) do table.insert(config.keys, {mods="ALT", key=v[1], action=v[2]}) end

-- ALT+SHIFT combinations
table.insert(config.keys, {mods="ALT|SHIFT", key="Enter", action=act.SplitVertical{domain='CurrentPaneDomain'}})

-- Tab navigation (ALT+1-8)
for i = 0, 7 do table.insert(config.keys, {mods="ALT", key=tostring(i+1), action=act.ActivateTab(i)}) end

-- Tab movement and last tab (CTRL+ALT)
for _, v in ipairs({
  {"UpArrow", act.ActivateLastTab}, {"DownArrow", act.ActivateLastTab},
  {"LeftArrow", act.MoveTabRelative(-1)}, {"RightArrow", act.MoveTabRelative(1)}
}) do table.insert(config.keys, {mods="CTRL|ALT", key=v[1], action=v[2]}) end
for i = 0, 7 do table.insert(config.keys, {mods="CTRL|ALT", key=tostring(i+1), action=act.MoveTab(i)}) end

-- Font configuration
config.font = wezterm.font_with_fallback({
  {family='JetBrains Mono', weight='Regular'},  
})
config.font_size = 12
config.line_height = 1.15
config.window_frame = {
  font = wezterm.font{family='JetBrains Mono', weight='Regular', style='Italic'},
  font_size = 12.0,
}

config.freetype_render_target = "Normal"
config.freetype_load_target = "Normal"
config.freetype_load_flags = "NO_HINTING"

-- Performance settings
config.max_fps = 120
config.animation_fps = 1
config.window_background_opacity = 1
config.enable_scroll_bar = false
config.use_fancy_tab_bar = true
config.term = "xterm-256color"
config.warn_about_missing_glyphs = false
-- Auto-detect Wayland based on environment
local is_wayland = os.getenv("WAYLAND_DISPLAY") ~= nil or
                   os.getenv("XDG_SESSION_TYPE") == "wayland"
config.enable_wayland = is_wayland
config.front_end = "OpenGL"
config.webgpu_power_preference = "HighPerformance"
config.prefer_egl = true
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.hide_tab_bar_if_only_one_tab = true

-- Color scheme
config.colors = {
  tab_bar = {
    inactive_tab_edge=colors.invisibles,
  }
}

-- Theme
config.color_scheme = "Kanagawa Dragon (Gogh)"

-- Mouse bindings
config.mouse_bindings = {
  {event={Down={streak=1, button="Right"}}, mods="NONE", action=act.CopyTo("Clipboard")},
  {event={Down={streak=1, button="Middle"}}, mods="NONE", action=act.SplitHorizontal{domain="CurrentPaneDomain"}},
  {event={Down={streak=1, button="Middle"}}, mods="SHIFT", action=act.CloseCurrentPane{confirm=false}}
}

return config

