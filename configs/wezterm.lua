local wezterm = require 'wezterm'

return {
  color_scheme = "Ryuuko",
  default_cwd = "/Users/yerlan.sergaziyev/Gerrit",
  default_prog = {"/Users/yerlan.sergaziyev/.cargo/bin/nu"},
  font = wezterm.font('JetBrains Mono'),
  font_size = 23,
  keys = {
    { key = "Backspace", mods = "SHIFT", action = wezterm.action.SendString("\x1Bb") }, -- Alt-b
    { key = "End", mods = "", action = wezterm.action.SendString("\x1B") }, -- Esc
    { key = "End", mods = "SHIFT", action = wezterm.action.SendString("\x1B_") }, -- Alt-_
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1Bf") }, -- Alt-f
    { key = "Space", mods = "SHIFT", action = wezterm.action.SendString("\x1B^") }, -- Alt-^
  },
  window_frame = { font_size = 24 },
  window_decorations = "RESIZE"
}
