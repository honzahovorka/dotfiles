# Cloudflare WARP Omarchy Widget

Omarchy bar widget for [Cloudflare WARP](https://one.one.one.one/), replacing the
`custom/warp` module this setup used under waybar.

## Features

- Shows WARP connection state in the bar: the theme's accent colour when
  connected, the ordinary bar foreground when not
- Left click opens a keyboard-friendly panel with a toggle switch and status
- Right click toggles WARP without opening the panel; middle click refreshes
- Reports the reason WARP gives for its current state
- Hides itself entirely when `warp-cli` is not installed

## Keyboard shortcuts

Inside the panel:

- `t`: toggle WARP
- `r`: refresh status
- `tab`: move to the next bar panel
- `esc`: close

## Settings

`refreshIntervalSec` (default 5, range 2–3600) controls how often `warp-cli status`
is polled. Set it inline on the widget's entry in `~/.config/omarchy/shell.json`.

## Requirements

- `warp-cli` on `PATH` (the `cloudflare-warp` package)

## Layout

- `Panel.qml` — bar icon plus the popup panel
- `Service.qml` — `warp-cli` polling and connect/disconnect actions
- `Model.js` — status parsing, kept free of QML

The split mirrors the first-party `panels/tailscale` and `panels/dropbox` plugins.

## Notes

The toggle is optimistic: the switch and icon move the moment it is clicked and
only fall back if `warp-cli` reports a failure, because WARP takes a beat to
settle. A status poll that hangs is reaped so it cannot wedge the widget.
