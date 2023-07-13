local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  color_scheme = "Catppuccin Mocha",
  default_prog = {
    "/Users/yerlan/.cargo/bin/nu",
    "--config", "/Users/yerlan/Published/configs/nushell/config.nu",
    "--env-config", "/Users/yerlan/Published/configs/nushell/env.nu"
  },
  font = wezterm.font('Monaco'),
  font_size = 19,
  line_height = 1.0,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  hide_tab_bar_if_only_one_tab = true,
  send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = false,
  leader = { key = 'Period', mods = 'CMD', timeout_milliseconds = 1000 },
  -- unzoom_on_switch_pane = false,
  keys = {
    { key = "Backspace" , mods = "SHIFT", action = wezterm.action.SendString("\x0B") }, -- Ctrl-k
    { key = "Backspace" , mods = "CTRL", action = wezterm.action.SendString("\x1B\x7F") }, -- Ctrl-k
    { key = "Backspace" , mods = "ALT", action = wezterm.action.SendString("\x1B-\x1Bu") }, -- Alt-minus Alt-u
    { key = "Backspace" , mods = "ALT|SHIFT", action = wezterm.action.SendString("\x15") }, -- Ctrl-u
    { key = "Return" , mods = "ALT", action = wezterm.action.SendString("\x1B[F") }, -- End
    { key = "Return" , mods = "ALT|SHIFT", action = wezterm.action.SendString("\x0F") }, -- Ctrl-o
    { key = "Tab" , mods = "ALT", action = wezterm.action.SendString("\x1Bf") }, -- Alt-f
    { key = "Tab" , mods = "ALT|SHIFT", action = wezterm.action.SendString("\x12") }, -- Ctrl-r
    { key = "Space" , mods = "ALT", action = wezterm.action.SendString("\x1B") }, -- Escape
    { key = "Space" , mods = "ALT|SHIFT", action = wezterm.action.SendString("\x1B[A") }, -- Up
    { key = "d" , mods = "SUPER", action = wezterm.action.SplitPane { direction = 'Down' } },
    { key = "t" , mods = "SUPER", action = wezterm.action.SplitPane { direction = 'Right' } },
    { key = "LeftBracket" , mods = "SUPER", action = wezterm.action.ActivatePaneDirection 'Prev' },
    { key = "RightBracket" , mods = "SUPER", action = wezterm.action.ActivatePaneDirection 'Next' },
    { key = "Return" , mods = "SUPER|SHIFT", action = wezterm.action.TogglePaneZoomState },
    -- { key = 'Return', mods = 'CMD', action = wezterm.action_callback(
    --   function(win, pane)
    --     win:maximize()
    --   end
    -- ) },
  },
  use_ime = false,
  window_decorations = "RESIZE",
  -- debug_key_events = true,
}
