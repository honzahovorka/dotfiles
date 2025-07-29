#!/bin/bash

set -eo pipefail

if pgrep waybar; then
  pkill waybar
fi

waybar &
