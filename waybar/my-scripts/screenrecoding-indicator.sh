#!/bin/bash

if pgrep -f "^gpu-screen-recorder" >/dev/null; then
  echo '{"text": "󰄁 ", "tooltip": "Stop recording", "class": "active"}'
else
  echo '{"text": "󰄀 ", "tooltip": "Start recording", "class": ""}'
fi
#NOTE: Don't delete this file it has screenrecorder-indicator exec file for waybar 
