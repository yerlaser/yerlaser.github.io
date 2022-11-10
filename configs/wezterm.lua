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
  font = wezterm.font('Monaco'),
  font_size = 17,
  keys = {
    { key = "Backspace", mods = "SHIFT", action = wezterm.action.SendString("\x1Bb") }, -- Alt-b
    { key = "DownArrow", mods = "SHIFT", action = wezterm.action.SendString("\x1B_") }, -- Alt-_
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1Bf") }, -- Alt-f
    { key = "Space", mods = "SHIFT", action = wezterm.action.SendString("\x1B^") }, -- Alt-^
  },
  window_frame = { font_size = 17 },
  window_decorations = "RESIZE"
}
