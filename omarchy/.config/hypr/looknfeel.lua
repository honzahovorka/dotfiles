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
