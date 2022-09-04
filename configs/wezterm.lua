local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  color_scheme = "Catppuccin Latte",
  default_cwd = "/Users/yerlan.sergaziyev/Gerrit",
  default_prog = {"/Users/yerlan.sergaziyev/.cargo/bin/nu", "--config", "/Users/yerlan.sergaziyev/Published/configs/configWez.nu"},
  enable_tab_bar = false,
  font = wezterm.font('JetBrains Mono'),
  font_size = 23,
  keys = {
    { key = "Backspace", mods = "SHIFT", action = wezterm.action.SendString("\x1Bb") }, -- Alt-b
    { key = "End", mods = "", action = wezterm.action.SendString("\x1B") }, -- Esc
    { key = "End", mods = "SHIFT", action = wezterm.action.SendString("\x1B_") }, -- Alt-_
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1Bf") }, -- Alt-f
    { key = "Space", mods = "SHIFT", action = wezterm.action.SendString("\x1B^") }, -- Alt-^
  },
  window_frame = { font_size = 23 },
  window_decorations = "RESIZE"
}
