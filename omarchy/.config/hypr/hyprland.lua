-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config. It is also what
-- puts ~/.config on package.path, so the `hypr.*` requires below resolve to the
-- files next to this one.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Temporary backport of the Quake console coming in Omarchy 4.1. The plugin
-- detects the upstream module and becomes a no-op once the release provides it.
require("hypr.plugins.qconsole")

-- Personal overrides, loaded after Omarchy's defaults so package updates can
-- improve the defaults without rewriting these files.
--
-- monitors.lua is deliberately NOT tracked in this repo: omarchy-hyprland-monitor-scaling
-- (SUPER + SLASH) rewrites it in place and omarchy-hyprland-monitor-clamshell reads
-- its locals, so a symlink into the dotfiles checkout would dirty the repo every
-- time the display setup changes. Per-host settings that *should* be tracked live
-- in machines/$HOST.lua instead.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Per-host settings, tracked in git. The hostname comes from /etc/hostname rather
-- than $HOST: the old .conf setup relied on fish exporting $HOST into Hyprland's
-- environment, and nothing here needs that. A host with no file is a no-op.
local function hostname()
  local file = io.open("/etc/hostname", "r")
  if not file then
    return nil
  end

  local name = file:read("l")
  file:close()

  return name and name:match("^%s*(.-)%s*$")
end

local host = hostname()
if host and host ~= "" then
  require("default.hypr.require_optional").module("hypr.machines." .. host)
end

-- Toggle config flags dynamically. Last on purpose, so `omarchy toggle ...` still
-- outranks the per-host settings above (that is how toggling the internal display
-- off keeps working on a machine that pins a monitor).
require("default.hypr.toggles")
