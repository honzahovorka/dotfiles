-- Temporary backport of Omarchy's Quake console from PRs #7409 and #7420.
-- Once Omarchy 4.1 loads its own module, leave every setting and binding to it.
if package.loaded["default.hypr.qconsole"] then
  return
end

-- Keep the original scratchpad shortcuts and add the Quake-style grave aliases.
o.bind("SUPER + grave", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind("SUPER + SHIFT + grave", "Move window to scratchpad", hl.dsp.window.move({
  workspace = "special:scratchpad",
  follow = false,
}))

-- How much of the usable screen the console covers, measured from the top.
local share = 0.5

-- Start the configured default agent only when the console is first opened.
-- Pinning the command to the special workspace avoids relying on spawn timing.
local seed = "[workspace special:scratchpad silent] omarchy-agent"

-- Dimming only applies while a special workspace is open.
hl.config({
  decoration = {
    dim_special = 0.6,
  },
})

-- Replacing a workspace rule schedules a state refresh, so avoid rewriting it
-- when moving between monitors that need the same bottom gap.
local covering = nil

local function cover(bottom)
  if covering == bottom then
    return
  end
  covering = bottom

  hl.workspace_rule({
    workspace = "special:scratchpad",
    gaps_in = 10,
    gaps_out = { top = 0, right = 0, bottom = bottom, left = 0 },
    no_border = true,
    on_created_empty = seed,
  })
end

-- Gaps are recalculated with the layout, unlike a window rule whose size is
-- fixed when the window maps. Monitor sizes are physical pixels while gaps and
-- reserved areas are logical, so account for output scaling first.
local function fit()
  local monitor = hl.get_active_monitor()

  -- Output handles may briefly be unreadable during a layout change.
  if not monitor or not monitor.scale or monitor.scale <= 0 then
    return
  end

  local reserved = monitor.reserved
  local usable = monitor.height / monitor.scale - reserved.top - reserved.bottom

  cover(math.max(0, math.floor(usable * (1 - share))))
end

-- Windows in the drawer are floated on purpose. `layout:single_window_aspect_ratio`
-- (SUPER + CTRL + BACKSPACE) coerces a lone *tiled* window into the configured
-- square, which coming from a 5120px-wide output shrinks the console from a
-- full-width band to a 1067px box parked mid-screen. Hyprland 0.56 gives no way to
-- scope that option: it is global, a workspace rule's `layout_opts` silently ignores
-- it, and changing it at runtime needs a relayout to land. Floating is the one state
-- the tiling layout never coerces, so the drawer opts out by not being tiled.
local function shape(window)
  local monitor = hl.get_active_monitor()

  -- Same guard as fit(): output handles can be unreadable mid-layout-change.
  if not window or not monitor or not monitor.scale or monitor.scale <= 0 then
    return
  end

  local reserved = monitor.reserved
  local usable = monitor.height / monitor.scale - reserved.top - reserved.bottom

  -- float() toggles, so only flip a window that is still tiled.
  if not window.floating then
    hl.dispatch(hl.dsp.window.float(window))
  end

  hl.dispatch(hl.dsp.window.resize({
    x = math.floor(monitor.width / monitor.scale),
    y = math.floor(usable * share),
    window = window,
  }))
  hl.dispatch(hl.dsp.window.move({ x = 0, y = reserved.top, window = window }))
end

local function shape_all()
  for _, window in ipairs(hl.get_workspace_windows("special:scratchpad") or {}) do
    shape(window)
  end
end

-- Seed a safe rule before outputs are available, then fit it to the active one.
cover(0)
fit()

local function refit()
  fit()
  shape_all()
end

hl.on("monitor.layout_changed", refit)
hl.on("monitor.focused", refit)

-- The drawer is toggled open before its seed window exists, so shape on every moment
-- one can appear: special_active for reopening it, window.open for the seed spawned by
-- on_created_empty, and move_to_workspace for anything stashed in with
-- SUPER + SHIFT + grave. shape() is idempotent, so overlapping events are harmless.
hl.on("workspace.special_active", shape_all)
hl.on("window.open", shape_all)
hl.on("window.move_to_workspace", shape_all)

-- Drop down from the top and retract through the same edge.
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide top" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "easeInOutCubic", style = "slide bottom" })
