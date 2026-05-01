#!/usr/bin/env bash

status=$(warp-cli status 2>/dev/null)

if echo "$status" | grep -q "Connected"; then
    echo '{"text": "󰒃", "tooltip": "WARP: Connected", "class": "connected"}'
else
    echo '{"text": "󰒃", "tooltip": "WARP: Disconnected", "class": "disconnected"}'
fi
