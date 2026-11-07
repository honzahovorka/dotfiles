-- Change the default Omarchy look'n'feel.

-- Steam's main window floats on its own; tile it like everything else.
o.window("steam", { tile = true })

-- omasnap's overlay is a layer surface it screenshots behind, so it must not
-- animate in, and it stays out of screen shares and recordings.
hl.layer_rule({
  match = { namespace = "^omasnap$" },
  no_anim = true,
  animation = "none",
  no_screen_share = true,
})

-- Diablo IV maps tiled, gets squared by the single-window aspect ratio, and
-- never re-fits after Wine fullscreens it. Fullscreen from the first frame.
o.window({ class = "^steam_app_battlenet$", title = "^Diablo IV$" }, { fullscreen = true })

-- Opt another application in to Omarchy's standard transparency.
-- Find its class with: hyprctl clients
-- o.transparent_window("my-app")
-- o.transparent_window("my-app", "0.9 0.85") -- Custom active/inactive opacity.
