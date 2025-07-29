#!/bin/bash

if nordvpn status | grep -q "Status: Connected"; then
  vpn_status=$(nordvpn status | sed ':a;N;$!ba;s/\n/\\n/g; s/"/\\"/g')
  echo "{\"text\": \"VPN 󰦝\", \"class\": \"connected\", \"tooltip\": \"$vpn_status\"}"
else
  echo "{\"text\": \"󱦛\", \"class\": \"disconnected\", \"tooltip\": \"Connect to VPN\"}"
fi
