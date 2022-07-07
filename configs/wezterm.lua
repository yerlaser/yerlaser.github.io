local wezterm = require 'wezterm'

return {
  color_scheme = "Dracula+",
  default_cwd = "/Users/yerlan.sergaziyev/Gerrit",
  default_prog = {"/Users/yerlan.sergaziyev/Sources/nushell/target/release/nu"},
  font = wezterm.font('JetBrains Mono'),
  font_size = 23,
  keys = {
    { key = "Backspace", mods = "SHIFT", action = wezterm.action.SendString("\x1b[1;2D") }
  },
  window_frame = { font_size = 21 }
}
