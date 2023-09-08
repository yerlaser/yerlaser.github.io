local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  color_scheme = "Catppuccin Latte",
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
  unzoom_on_switch_pane = true,
  leader = { key = "q", mods = "SUPER", timeout_milliseconds = 3000 },
  keys = {
    { key = "q"         , mods = "SUPER"      , action = wezterm.action.DisableDefaultAssignment },
    { key = "w"         , mods = "SUPER"      , action = wezterm.action.DisableDefaultAssignment },
    { key = "w"         , mods = "SUPER"      , action = wezterm.action.ActivatePaneDirection "Next" },
    { key = "x"         , mods = "SUPER"      , action = wezterm.action.ActivateCopyMode },
    { key = "d"         , mods = "LEADER"     , action = wezterm.action.SplitPane { direction = "Down" } },
    { key = "r"         , mods = "LEADER"     , action = wezterm.action.SplitPane { direction = "Right" } },
    { key = "h"         , mods = "LEADER"     , action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "j"         , mods = "LEADER"     , action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "k"         , mods = "LEADER"     , action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "l"         , mods = "LEADER"     , action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "f"         , mods = "LEADER"     , action = wezterm.action.TogglePaneZoomState },
    { key = "q"         , mods = "LEADER"     , action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = "w"         , mods = "LEADER"     , action = wezterm.action.CloseCurrentPane { confirm = true } },
    { key = "Backspace" , mods = "ALT"        , action = wezterm.action.SendString("\x1B[D") }, -- Left
    { key = "Backspace" , mods = "ALT|SHIFT"  , action = wezterm.action.SendString("\x1B[1;2H") }, -- Shift-Home
    { key = "Backspace" , mods = "SHIFT"      , action = wezterm.action.SendString("\x1B\x7F") }, -- Alt-Backspace
    { key = "Backspace" , mods = "CTRL"       , action = wezterm.action.SendString("\x1B\x7F") }, -- Alt-Backspace
    { key = "Return"    , mods = "ALT"        , action = wezterm.action.SendString("\x1B[C") }, -- Right
    { key = "Return"    , mods = "ALT|SHIFT"  , action = wezterm.action.SendString("\x1B[1;2F") }, -- Shift-End
    { key = "Return"    , mods = "SHIFT"      , action = wezterm.action.SendString("\x1B") }, -- Escape
    { key = "Return"    , mods = "CTRL"       , action = wezterm.action.SendString("\x1B-\x1Bu") }, -- Alt-- Alt-u
    { key = "Return"    , mods = "CTRL|SHIFT" , action = wezterm.action.SendString("\x1B-\x1Bl") }, -- Alt-- Alt-l
    { key = "Space"     , mods = "ALT"        , action = wezterm.action.SendString("\x1B[A") }, -- Up
    { key = "Space"     , mods = "ALT|SHIFT"  , action = wezterm.action.SendString("\x1B[5;2~") }, -- Shift-PageUp
    { key = "Space"     , mods = "CTRL|SHIFT" , action = wezterm.action.SendString("\x0F") }, -- Ctrl-o
    { key = "Tab"       , mods = "ALT"        , action = wezterm.action.SendString("\x1B[B") }, -- Down
    { key = "Tab"       , mods = "ALT|SHIFT"  , action = wezterm.action.SendString("\x1B[6;2~") }, -- Shift-PageDown
    { key = "UpArrow"   , mods = "CMD"        , action = wezterm.action_callback(
      function(win, pane)
        win:maximize()
      end
    ) },
  },
  use_ime = false,
  window_decorations = "RESIZE",
  -- debug_key_events = true,
}
