# Local patches

Patches applied by hand to things that live outside this repo (omarchy shell
plugins are plain git clones under `~/.config/omarchy/plugins/`, untracked here).
Kept so they survive a plugin reinstall and are visible in `git status`.

## tray-plugin-bar-api.patch

**Target:** `~/.config/omarchy/plugins/io.github.tyrichards.tray/Tray.qml`
**Upstream:** https://github.com/TyRichards/omarchy-tray/pull/8 (open, unmerged)

Omarchy 4.0.3 stopped handing third-party bar widgets the real `Bar` object and
gave them the `Ui/PluginBarApi.qml` facade instead, which omits
`barWidgetRegistry`, `pressModuleClickTarget` and the `barDrag*` surface. The
tray hosts other widgets, so its drawer went silently empty — no QML errors,
because it guards every host call with `typeof … === "function"`.

The patch walks the bar Row, finds a first-party sibling that still holds the
host `Bar`, and reassigns the tray's own `bar` to it. It is a sandbox escape
racing the host's `injectProps()`, hence the 250ms retry timer. Applied
2026-09-16 as a deliberate trade, not an endorsement.

```bash
git -C ~/.config/omarchy/plugins/io.github.tyrichards.tray apply \
  ~/git/dotfiles/docs/patches/tray-plugin-bar-api.patch
omarchy restart shell
```

**Remove when** upstream merges a fix (then `omarchy plugin update` refuses to
fast-forward until you `git checkout -- Tray.qml`), or when the tray is swapped
for `TomFaulkner/omarchy-popout-tray` or the stock `omarchy.tray`.
