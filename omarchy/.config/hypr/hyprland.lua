-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config. It is also what
-- puts ~/.config on package.path, so the `hypr.*` requires below resolve to the
-- files next to this one.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults.
require("default.hypr.omarchy")

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

-- Machine-local monitor layout, owned by hyprmon and untracked. hyprmon's Lua
-- mode writes its rules to ~/.config/hypr/hyprmon.lua and looks in here for a
-- line that is exactly `require("hyprmon")` — when found it leaves this file
-- alone; otherwise it appends its own copy straight through the stow symlink,
-- dirtying the repo. Loaded after machines/$HOST so an applied profile
-- outranks per-host monitor rules; only the omarchy toggles below outrank it,
-- which is intended (that is how `omarchy toggle` can still disable the
-- internal monitor). The io.open guard keeps a machine that has never run
-- hyprmon out of Hyprland's emergency config, and clearing package.loaded
-- keeps `hyprctl reload` re-reading the sidecar (the bootstrap only un-caches
-- its own module prefixes, and "hyprmon" is not one of them).
local hyprmon_sidecar = io.open(os.getenv("HOME") .. "/.config/hypr/hyprmon.lua", "r")
if hyprmon_sidecar then
  hyprmon_sidecar:close()
  package.loaded["hyprmon"] = nil
  require("hyprmon")
end

-- Toggle config flags dynamically. Last on purpose, so `omarchy toggle ...` still
-- outranks the per-host settings above (that is how toggling the internal display
-- off keeps working on a machine that pins a monitor).
require("default.hypr.toggles")
