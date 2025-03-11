#!/bin/sh

# Set default cursor
xsetroot -cursor_name left_ptr

# Start background applications
feh --bg-fill --randomize ~/Pictures/wallpapers/* &
dunst &
udiskie &
syncthing --no-desktop &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
clipster -d 2>/dev/null &
mpd &
sxhkd &
mpc load Favourites && mpc random on && mpc play && mpc pause &
~/Github/scripts/wacom.sh &

# Start status bar
dwmblocks &

# Start DWM
exec dwm
