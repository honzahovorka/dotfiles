-- NOTE: no hl.monitor() calls here on purpose. The Dell ultrawide's rule lives
-- in the machine-local, untracked ~/.config/hypr/monitors.lua so that
-- omarchy-hyprland-monitor-scaling (topbar display section / SUPER + SLASH) can
-- manage the scale: it persists into monitors.lua's omarchy_monitor_scale
-- local, and a desc: rule here loads later and would stomp the scale back on
-- every config reload. Same policy titan follows.

-- Boot without idle locking. This used to wait for hypridle to appear and then
-- flip it; quattro runs idle inside omarchy-shell and keeps the answer in a state
-- file, so setting it directly is enough. Toggle it later with SUPER + CTRL + I.
o.exec_on_start("omarchy-toggle-idle stay-awake")

-- Nothing here pins the single-window aspect ratio any more: it is a first-class
-- Omarchy toggle now (SUPER + CTRL + BACKSPACE), persisted across restarts in
-- ~/.local/state/omarchy/toggles/hypr/.

-- Omarchy's stock 875x600 float size is dwarfed by the 40" ultrawide. About is
-- exempt: omarchy-launch-about sizes it to hug the fastfetch content each launch.
o.window({ tag = "floating-window" }, { size = { 2000, 1300 } })
