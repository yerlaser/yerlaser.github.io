local wezterm = require 'wezterm';
return {
  font = wezterm.font('Monaco'),
  font_size = 19.0,
  keys = {
    {key="Backspace", mods="SHIFT", action=wezterm.action.SendString("\x1b[1;2D")}
  },
  default_prog = {"/Users/yerlan.sergaziyev/Sources/nushell/target/release/nu"},
  default_cwd = "/Users/yerlan.sergaziyev/Gerrit",
}
