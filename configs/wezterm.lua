local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  color_scheme = "Catppuccin Latte",
  -- default_cwd = "",
  default_prog = {
    "/Users/yerlan/.cargo/bin/nu",
    "--config", "/Users/yerlan/Published/configs/configLight.nu",
    "--env-config", "/Users/yerlan/Published/configs/envLight.nu"
  },
  font = wezterm.font('Monaco'),
  font_size = 18,
  leader = { key = 'Semicolon', mods = 'CMD', timeout_milliseconds = 1000 },
  keys = {
    { key = "Backspace" , mods = "SHIFT", action = wezterm.action.SendString("\x1Bb") }, -- Alt-b
    { key = "Delete" , mods = "", action = wezterm.action.SendString("\x1B\x1B") }, -- Escape
    { key = "Enter"     , mods = "SHIFT", action = wezterm.action.SendString("\x1Bf") }, -- Alt-f
    { key = "Space"     , mods = "SHIFT", action = wezterm.action.SendString("\x1B^") }, -- Alt-^
    { key = "Tab"     , mods = "CTRL", action = wezterm.action.SendString("\x1Bt") }, -- Alt-t
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
    { key = "Delete" , mods = "CMD", action = wezterm.action.PaneSelect    },
    { key = "Comma" , mods = "CMD", action = wezterm.action.ActivateTabRelativeNoWrap(-1)    },
    { key = "Period" , mods = "CMD", action = wezterm.action.ActivateTabRelativeNoWrap(1)    },
  },
  window_frame = { 
    font_size = 18,
    active_titlebar_bg = '#CCCCCC',
  },
  window_decorations = "RESIZE",
  -- debug_key_events = true,
}
