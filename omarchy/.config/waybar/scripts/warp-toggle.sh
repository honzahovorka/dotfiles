#!/usr/bin/env bash

status=$(warp-cli status 2>/dev/null)

if echo "$status" | grep -q "Connected"; then
    warp-cli disconnect > /dev/null 2>&1
else
    warp-cli connect > /dev/null 2>&1
fi
