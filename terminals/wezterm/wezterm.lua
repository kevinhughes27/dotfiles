local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- set font size based on OS
local _success, stdout, _stderr = wezterm.run_child_process { 'uname' }
local font_size = 10
if string.match(stdout, 'Darwin') then
  font_size = 13
end
config.font_size = font_size

-- font
config.font = wezterm.font_with_fallback {
  'Hack Nerd Font',
  'Noto Color Emoji',
}

-- colors
config.color_scheme = 'OneDark (base16)'
local color_bg = '#31353F'
local color_fg = '#abb2bf'
local color_magenta = '#c678dd'
local color_blue = '#61afef'

-- tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- tab bar font size
config.window_frame = {
  font_size = font_size,
}

-- tab config
local UPPER_LEFT_TRIANGLE = wezterm.nerdfonts.ple_upper_right_triangle
local LOWER_LEFT_TRIANGLE = wezterm.nerdfonts.ple_lower_left_triangle

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- otherwise, use the title from the active pane in that tab
  return tab_info.active_pane.title
end

wezterm.on('update-status', function(window, pane)
  window:set_left_status(wezterm.format {
    { Background = { Color = color_blue } },
    { Foreground = { Color = color_bg } },
    { Attribute = { Intensity = 'Bold' } },
    { Text = ' WEZTERM ' },
    { Background = { Color = color_blue } },
    { Foreground = { Color = color_bg } },
    { Text = UPPER_LEFT_TRIANGLE },
  })
  window:set_right_status ''
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local edge_background = color_bg
  local background = color_bg
  local foreground = color_fg

  if tab.is_active or hover then
    background = color_magenta
    foreground = color_bg
  end

  local edge_foreground = background

  local intensity = 'Normal'
  if tab.is_active then
    intensity = 'Bold'
  end

  local title = tab_title(tab)

  -- ensure that the titles fit in the available space,
  -- and that we have room for the edges.
  title = wezterm.truncate_right(title, max_width - 4)

  if tab.is_active or hover then
    title = title .. "  "
  else
    title = title .. " \\"
  end

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = UPPER_LEFT_TRIANGLE },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Attribute = { Intensity = intensity } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = LOWER_LEFT_TRIANGLE },
  }
end)

config.colors = {
  tab_bar = {
    background = color_bg,
    inactive_tab_hover = {
      bg_color = color_magenta,
      fg_color = color_bg,
      italic = false,
    },
    new_tab = {
      bg_color = color_bg,
      fg_color = color_fg,
    },
  }
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 5,
  bottom = 0,
}
config.window_background_opacity = 1.0

-- tmux style prefix key
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen
  },
  {
    mods = 'CTRL',
    key = 'v',
    action = wezterm.action.PasteFrom 'Clipboard'
  },
  {
    mods = 'LEADER',
    key = 't',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain'
  },
  {
    mods   = 'LEADER',
    key    = '\\',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  {
    mods   = 'LEADER',
    key    = '-',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    mods   = 'LEADER',
    key    = 'LeftArrow',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    mods   = 'LEADER',
    key    = 'RightArrow',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    mods   = 'LEADER',
    key    = 'UpArrow',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    mods   = 'LEADER',
    key    = 'DownArrow',
    action = wezterm.action.ActivatePaneDirection 'Down',
  }
}

config.mouse_bindings = {
  -- Change the default click behavior so that it populates
  -- the Clipboard rather the PrimarySelection.
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
  },
}

config.audible_bell = 'Disabled'

return config
