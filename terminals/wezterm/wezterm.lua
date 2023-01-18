local wezterm = require "wezterm"

return {
  color_scheme = "OneDark (base16)",

  font = wezterm.font_with_fallback {
    "Hack Nerd Font",
    "Noto Color Emoji",
  },
  font_size = 11,

  enable_tab_bar = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 2,
    bottom = 0,
  },
  window_background_opacity = 1.0,

  keys = {
    { key = 'v', mods = 'CTRL', action = wezterm.action.Paste },
    { key = 'F11', action = wezterm.action.ToggleFullScreen },
  },

  mouse_bindings = {
    -- Change the default click behavior so that it populates
    -- the Clipboard rather the PrimarySelection.
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
    },
  },

  audible_bell = "Disabled",
}
