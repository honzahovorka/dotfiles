-- Extra autostart processes.
--
-- The second argument to hl.exec_cmd carries the rules the old
-- `exec-once = [workspace 1 silent] ...` syntax encoded inline. `silent` keeps
-- the workspace from being pulled into focus as each app claims its window.
hl.on("hyprland.start", function()
  hl.exec_cmd("omarchy-launch-browser", { workspace = "1 silent" })
  hl.exec_cmd("omarchy-launch-terminal", { workspace = "3 silent" })
  hl.exec_cmd(o.launch("slack"), { workspace = "4 silent" })
end)
