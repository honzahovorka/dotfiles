-- Fixed hardware: one 40" Dell ultrawide, never changes. Matched by description
-- rather than port so a different DP output doesn't need a config change.
hl.env("GDK_SCALE", "1")
hl.monitor({
  output = "desc:Dell Inc. DELL U4025QW 2BKRJ04",
  mode = "5120x2160@120",
  position = "auto",
  scale = 1,
})

-- Boot without idle locking. This used to wait for hypridle to appear and then
-- flip it; quattro runs idle inside omarchy-shell and keeps the answer in a state
-- file, so setting it directly is enough. Toggle it later with SUPER + CTRL + I.
o.exec_on_start("omarchy-toggle-idle stay-awake")

-- Nothing here pins the single-window aspect ratio any more: it is a first-class
-- Omarchy toggle now (SUPER + CTRL + BACKSPACE), persisted across restarts in
-- ~/.local/state/omarchy/toggles/hypr/.
