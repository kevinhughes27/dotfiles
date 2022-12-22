local wezterm = require "wezterm"

return {
  color_scheme = "OneDark (base16)",
  font = wezterm.font_with_fallback {
    "Hack Nerd Font",
    "Noto Color Emoji",
  },
  font_size = 14,
  enable_tab_bar = false,
  window_background_opacity = 0.96,
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
}
