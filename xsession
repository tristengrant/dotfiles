#!/bin/sh

# Set default cursor
xsetroot -cursor_name left_ptr

# Start background applications
feh --bg-fill --randomize ~/Pictures/wallpapers/* &
dunst &
udiskie &
syncthing --no-browser &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
clipster -d 2>/dev/null &
mpd &
sxhkd &
mpc load Favourites && mpc random on && mpc play && mpc pause &
~/Github/scripts/nosleep.sh &
~/Github/scripts/wacom.sh &
xremap --device "HID 04f3:0635" ~/Github/dotfiles/xremap.yml &

# Start status bar
dwmblocks &

# Start DWM
exec dwm
