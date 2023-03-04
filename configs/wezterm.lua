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
    "--config", "/Users/yerlan/Published/configs/configLight.nu",
    "--env-config", "/Users/yerlan/Published/configs/envLight.nu"
  },
  font = wezterm.font('Monaco'),
  font_size = 19,
  hide_tab_bar_if_only_one_tab = true,
  leader = { key = 'Period', mods = 'CMD', timeout_milliseconds = 1000 },
  keys = {
    { key = "Backspace" , mods = "SHIFT", action = wezterm.action.SendString("\x1B[A") }, -- Up
    { key = "Delete" , mods = "", action = wezterm.action.SendString("\x1B") }, -- (Caps) Escape
    { key = "Delete" , mods = "SHIFT", action = wezterm.action.SendString("\x1Br") }, -- (Caps) Alt-r
    { key = "Enter"     , mods = "SHIFT", action = wezterm.action.SendString("\x1B[B") }, -- Down
    { key = "Space"     , mods = "SHIFT", action = wezterm.action.SendString("\x1B^") }, -- Alt-^
    { key = "LeftBracket"  , mods = "" , action = wezterm.action.SendString("[")     },
    { key = "LeftBracket"  , mods = "SHIFT", action = wezterm.action.SendString("{")     },
    { key = "RightBracket"  , mods = "" , action = wezterm.action.SendString("]")     },
    { key = "RightBracket"  , mods = "SHIFT", action = wezterm.action.SendString("}")     },
    { key = "Grave"     , mods = "" , action = wezterm.action.SendString("`")     },
    { key = "Grave"     , mods = "SHIFT", action = wezterm.action.SendString("~")     },
    { key = "Backslash" , mods = "" , action = wezterm.action.SendString("\\")    },
    { key = "Backslash" , mods = "SHIFT", action = wezterm.action.SendString("|")     },
    { key = "LeftBracket" , mods = "CMD", action = wezterm.action.SplitPane { direction = 'Left' }     },
    { key = "RightBracket" , mods = "CMD", action = wezterm.action.SplitPane { direction = 'Right' }     },
    { key = "Quote" , mods = "CMD", action = wezterm.action.SplitPane { direction = 'Up' }     },
    { key = "Slash" , mods = "CMD", action = wezterm.action.SplitPane { direction = 'Down' }     },
    { key = "Semicolon" , mods = "CMD", action = wezterm.action.PaneSelect    },
    { key = 'Comma', mods = 'CMD', action = wezterm.action_callback(
      function(win, pane)
        win:maximize()
      end
    )},
  },
  use_ime = false,
  window_decorations = "RESIZE",
  -- debug_key_events = true,
}
