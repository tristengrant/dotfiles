#!/bin/sh

# Start background applications
syncthing --no-browser &
xremap --device "HID 04f3:0635" ~/Github/dotfiles/xremap.yml &
