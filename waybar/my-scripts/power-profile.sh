#!/bin/bash

mode=$(powerprofilesctl get)

case "$mode" in
    "performance")
        icon=" "     # Rocket
        class="performance"
        ;;
    "balanced")
        icon=" "
        class="balanced"
        ;;
    "power-saver")
        icon=" "
        class="powersaver"
        ;;
esac

# Output JSON with a "class" field
echo "{\"text\": \"$icon\", \"tooltip\": \"Power Mode: $mode\", \"class\": \"$class\"}"

