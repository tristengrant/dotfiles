#!/bin/sh

# Start background applications
syncthing --no-browser &
xremap --device "HID 04f3:0635" ~/Github/dotfiles/xremap.yml &

xrandr --output DisplayPort-1 --mode 2560x1440 --pos 1200x480 --rotate normal --output DisplayPort-2 --mode 1920x1200 --pos 0x0 --rotate left
