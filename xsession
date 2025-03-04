# Load ~/.profile if it exists
[ -f ~/.profile ] && . ~/.profile

# Load environment from ~/.Xresources (fixed path)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set default cursor
xsetroot -cursor_name left_ptr  

# Start background applications
feh --bg-fill --randomize ~/Pictures/wallpapers/* &
dwmblocks &
dunst &
udiskie &
syncthing-gtk --hidden &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
clipster -d 2>/dev/null &
mpd &
sxhkd &
mpc load Favourites && mpc random on && mpc play && mpc pause &
~/Scripts/nosleep.sh &

# Start DWM
exec dwm
