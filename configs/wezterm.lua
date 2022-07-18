local wezterm = require 'wezterm'

return {
  color_scheme = "Ryuuko",
  default_cwd = "/Users/yerlan.sergaziyev/Gerrit",
  default_prog = {"/Users/yerlan.sergaziyev/Sources/nushell/target/release/nu"},
  font = wezterm.font('JetBrains Mono'),
  font_size = 23,
  keys = {
    { key = "Backspace", mods = "SHIFT", action = wezterm.action.SendString("\x12") }, -- Ctrl-r
    { key = "End", mods = "", action = wezterm.action.SendString("\x03") }, -- Ctrl-c
    { key = "End", mods = "SHIFT", action = wezterm.action.SendString("\x01") }, -- Ctrl-a
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x05") }, -- Ctrl-e
    { key = "Space", mods = "SHIFT", action = wezterm.action.SendString("\x18") }, -- Ctrl-x
  },
  window_frame = { font_size = 24 },
  window_decorations = "RESIZE"
}
