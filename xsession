#!/bin/sh

# Set default cursor
xsetroot -cursor_name left_ptr

# Start background applications
~/Github/scripts/dwm-status.sh &
feh --bg-fill --randomize ~/Pictures/wallpapers/* &
dunst &
udiskie &
syncthing --no-browser &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
clipster -d 2>/dev/null &
mpd &
sxhkd &
~/Github/scripts/wacom.sh &
xremap --device "HID 04f3:0635" ~/Github/dotfiles/xremap.yml &

# Auto setting music to favourites playlist at startup
mpc load favourites && mpc random on && mpc play && mpc pause &

# Disable monitor sleeping
xset s off
xset -dpms

# Start DWM
exec dwm
