-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Frappe'
  else
    return 'Catppuccin Latte'
  end
end

-- For example, changing the color scheme:
config.color_scheme =  scheme_for_appearance(wezterm.gui.get_appearance())

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 15.0

config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
