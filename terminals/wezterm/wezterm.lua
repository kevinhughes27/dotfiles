local wezterm = require 'wezterm'

local _success, stdout, _stderr = wezterm.run_child_process { 'uname' }

wezterm.log_info(stdout)

local font_size = 11
if string.match(stdout, 'Darwin') then
  font_size = 14
end

wezterm.log_info(font_size)

return {
  color_scheme = 'OneDark (base16)',

  font = wezterm.font_with_fallback {
    'Hack Nerd Font',
    'Noto Color Emoji',
  },
  font_size = font_size,

  enable_tab_bar = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 2,
    bottom = 0,
  },
  window_background_opacity = 1.0,

  keys = {
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
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

  audible_bell = 'Disabled',
}
