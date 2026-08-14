-- Personal input overrides. Only the deltas from Omarchy's defaults belong here;
-- see /usr/share/omarchy/default/hypr/input.lua for what is already set.
-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- Add a Czech layout. Omarchy derives kb_layout from /etc/vconsole.conf, so
    -- both layouts are spelled out here. The cz variant is qwerty so the letters
    -- don't move between layouts.
    kb_layout = "us,cz",
    kb_variant = ",qwerty",
    -- Deliberately NO grp:*_toggle here. Hyprland keeps xkb layout state per
    -- keyboard *device*, and this box has ten keyboard endpoints (Kinesis x3, an
    -- MX Vertical, AirPods' AVRCP interface, fcitx5's virtual keyboard, power
    -- buttons...). grp:alt_shift_toggle switched whichever endpoint happened to
    -- receive the combo -- in practice the AirPods and the fcitx5 virtual
    -- keyboard, never the Kinesis -- so the bar showed a new layout while typing
    -- carried on in the old one. Alt + Shift is bound in bindings.lua instead,
    -- to a switch that moves every device at once.
    kb_options = "compose:caps,shift:both_capslock_cancel",

    -- Wait longer before a held key starts repeating (Omarchy default: 250).
    repeat_delay = 600,

    touchpad = {
      -- Use natural (inverse) scrolling.
      natural_scroll = true,
    },
  },
})
