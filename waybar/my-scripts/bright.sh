#!/bin/bash

# GET brightness percentage
get_brightness() {
    brightnessctl -m | awk -F, '{print $4}' | tr -d '%'
}

# No arguments → print brightness
if [[ $# -eq 0 ]]; then
    echo "$(get_brightness)%"
    exit 0
fi

# Control brightness
case "$1" in
  up)
    brightnessctl set +5% >/dev/null
    ;;
  down)
    brightnessctl set 5%- >/dev/null
    ;;
esac

echo "$(get_brightness)%"

