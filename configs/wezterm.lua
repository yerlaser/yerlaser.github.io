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
  window_frame = {
    active_titlebar_bg = '#AAAAAA',
    inactive_titlebar_bg = '#777777',
  },
  hide_tab_bar_if_only_one_tab = false,
  send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = false,
  unzoom_on_switch_pane = true,
  leader = { key = "q", mods = "SUPER", timeout_milliseconds = 3000 },
  keys = {
    { key = "ä"         , mods = ""             , action = wezterm.action.SendString("`") },
    { key = "Ä"         , mods = "SHIFT"        , action = wezterm.action.SendString("~") },
    { key = "ü"         , mods = ""             , action = wezterm.action.SendString("[") },
    { key = "Ü"         , mods = "SHIFT"        , action = wezterm.action.SendString("{") },
    { key = "ö"         , mods = ""             , action = wezterm.action.SendString("]") },
    { key = "Ö"         , mods = "SHIFT"        , action = wezterm.action.SendString("}") },
    { key = "ß"         , mods = ""             , action = wezterm.action.SendString("=") },
    { key = "ü"         , mods = "CTRL"         , action = wezterm.action.SendString("\x1B") },
    { key = "ö"         , mods = "CTRL"         , action = wezterm.action.SendString("\x1D") },
    { key = ";"         , mods = "CTRL"         , action = wezterm.action.SendString("\x1B[C") }, -- Right
    -- { key = "'"         , mods = "CTRL"         , action = wezterm.action.SendString("\x1B[F") }, -- End
    { key = "q"         , mods = "SUPER"        , action = wezterm.action.DisableDefaultAssignment },
    { key = "w"         , mods = "SUPER"        , action = wezterm.action.DisableDefaultAssignment },
    { key = "w"         , mods = "SUPER"        , action = wezterm.action.ActivatePaneDirection "Next" },
    { key = "Space"     , mods = "CTRL|SHIFT"   , action = wezterm.action.ActivateCopyMode },
    { key = "d"         , mods = "LEADER"       , action = wezterm.action.SplitPane { direction = "Down" } },
    { key = "r"         , mods = "LEADER"       , action = wezterm.action.SplitPane { direction = "Right" } },
    { key = "h"         , mods = "LEADER"       , action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "j"         , mods = "LEADER"       , action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "k"         , mods = "LEADER"       , action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "l"         , mods = "LEADER"       , action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "f"         , mods = "LEADER"       , action = wezterm.action.TogglePaneZoomState },
    { key = 'h'         , mods = "LEADER|SHIFT" , action = wezterm.action.AdjustPaneSize { 'Left', 5 }, },
    { key = 'j'         , mods = "LEADER|SHIFT" , action = wezterm.action.AdjustPaneSize { 'Down', 5 }, },
    { key = 'k'         , mods = "LEADER|SHIFT" , action = wezterm.action.AdjustPaneSize { 'Up', 5 }, },
    { key = 'l'         , mods = "LEADER|SHIFT" , action = wezterm.action.AdjustPaneSize { 'Right', 5 }, },
    { key = "q"         , mods = "LEADER"       , action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = "w"         , mods = "LEADER"       , action = wezterm.action.CloseCurrentPane { confirm = true } },
    { key = "Backspace" , mods = "CTRL"         , action = wezterm.action.SendString("\x1B\x7F") }, -- Alt-Backspace
    { key = "Backspace" , mods = "SHIFT"         , action = wezterm.action.SendString("\x1B[3~") }, -- Del
    { key = "Return"    , mods = "CTRL"         , action = wezterm.action.SendString("\x1B[F") }, -- End
    { key = "UpArrow"   , mods = "CMD"          , action = wezterm.action_callback(
      function(win, pane)
        win:maximize()
      end
    ) },
  },
  use_ime = false,
  window_decorations = "RESIZE",
  -- debug_key_events = true,
}
