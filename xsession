# Load ~/.profile if it exists
[ -f ~/.profile ] && . ~/.profile

# Load environment from ~/.Xresources (fixed path)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set default cursor
xsetroot -cursor_name left_ptr

# Start background applications
feh --bg-fill --randomize ~/Pictures/wallpapers/* &
dunst &
udiskie &
syncthing-gtk --hidden &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
clipster -d 2>/dev/null &
mpd &
sxhkd &
mpc load Favourites && mpc random on && mpc play &
~/Scripts/nosleep.sh &

# Delay to ensure that DWM starts up properly before starting dwmblocks
dwmblocks &

# Start DWM
exec dwm
