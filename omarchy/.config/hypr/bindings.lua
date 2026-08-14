-- Personal keybinding overrides. Omarchy's defaults load first (see hyprland.lua),
-- so anything that collides has to be unbound before it can be rebound.
--
-- See current bindings and descriptions:
--   omarchy menu keybindings --print
--
-- Deliberately not repeated here: terminal, file manager, music, editor, docker,
-- Obsidian, passwords and the single-window square aspect toggle. Omarchy now
-- ships all of those on the same keys (SUPER + CTRL + BACKSPACE for the aspect
-- toggle), and omarchy-launch-terminal already opens in the active terminal's cwd.

-- Vim-style focus movement. All three letters are taken by default: SUPER + J
-- toggles the window split, SUPER + K opens the keybindings menu, and SUPER + L
-- toggles the workspace layout.
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")

o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + J", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + K", "Focus on below window", hl.dsp.focus({ direction = "d" }))

-- Throw the current workspace at the next/previous monitor.
o.bind("SUPER + SHIFT + H", "Move workspace to next monitor", hl.dsp.workspace.move({ monitor = "+1" }))
o.bind("SUPER + SHIFT + L", "Move workspace to previous monitor", hl.dsp.workspace.move({ monitor = "-1" }))

-- Browser on a bare key; Omarchy only ships SUPER + SHIFT + B.
o.bind("SUPER + B", "Browser", { omarchy = "browser" })

-- Close the focused window (Omarchy uses SUPER + W, which stays bound too).
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Web apps. Both keys belong to other apps by default: SUPER + SHIFT + G is
-- Signal and SUPER + SHIFT + A is ChatGPT.
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })

hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Claude", { webapp = "https://claude.ai" })

-- Screenshots. SUPER + CTRL + 1/2 are "Bar panel 1/2" by default, and are bound
-- by keycode there, so they have to be unbound the same way.
hl.unbind("SUPER + CTRL + code:10")
hl.unbind("SUPER + CTRL + code:11")
o.bind("SUPER + CTRL + code:10", "Screenshot", "omarchy-capture-screenshot smart")
o.bind("SUPER + CTRL + code:11", "Screenshot (clipboard)", "omarchy-capture-screenshot smart copy")

-- Keyboard layout switching, on Alt + Shift as always.
--
-- This is a Hyprland bind rather than xkb's grp:alt_shift_toggle because xkb
-- state is per keyboard *device*: the toggle only moved the endpoint that
-- received the combo, which on this machine was never the keyboard being typed
-- on. `switchxkblayout all` moves every device in lockstep instead, which also
-- keeps the bar's reading honest and works the same on a laptop's built-in
-- keyboard. It is a hyprctl command, not a dispatcher, so it has to be exec'd.
--
-- Both orders are bound because only the modifier held *first* is in the modmask
-- when the second one goes down. Key events are serialised, so exactly one of
-- these fires per gesture -- they can't double-toggle.
local switch_layout = "hyprctl switchxkblayout all next"
o.bind("ALT + Shift_L", "Switch keyboard layout", switch_layout)
o.bind("SHIFT + Alt_L", "Switch keyboard layout", switch_layout)

-- Consequence of the bind above: the layout switch fires the moment Shift goes
-- down with Alt held, so Omarchy's ALT + SHIFT + TAB ("Focus on previous window"
-- and "Reveal active window on top", two binds on the same key) would flip the
-- layout on the way through. Window focus lives on SUPER + hjkl here, so drop it.
-- Plain ALT + TAB and SUPER + ALT + SHIFT + TAB (group cycling) are untouched.
hl.unbind("ALT + SHIFT + TAB")

-- Resize mode: SUPER + R, then arrows or hjkl to resize, ESC or RETURN to leave.
hl.define_submap("resize", function()
  hl.bind("LEFT", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
  hl.bind("UP", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
  hl.bind("DOWN", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
  hl.bind("RIGHT", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))

  hl.bind("H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
  hl.bind("L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))

  hl.bind("ESCAPE", hl.dsp.submap("reset"))
  hl.bind("RETURN", hl.dsp.submap("reset"))
end)

o.bind("SUPER + R", "Resize mode", hl.dsp.submap("resize"))
