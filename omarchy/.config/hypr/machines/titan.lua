-- NOTE: no hl.monitor() calls here on purpose. This laptop's layout changes with
-- the desk, so it stays in the machine-local, untracked ~/.config/hypr/monitors.lua
-- that omarchy-hyprland-monitor-scaling writes and omarchy-hyprland-monitor-clamshell
-- reads. Pinning a geometry here would fight both of them.
--
-- Lid handling comes from Omarchy's defaults (omarchy-system-lid-close and
-- omarchy-hyprland-monitor-clamshell on the Lid Switch), which work out the
-- geometry at runtime instead of hardcoding an eDP-1 mode that would drift.

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 4,
	},
})
