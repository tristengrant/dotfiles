# Load ~/.profile if it exists
[ -f ~/.profile ] && . ~/.profile

# Load environment from ~/.Xresources (fixed path)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set DPI
xrandr --dpi 96

# Set Monitor Layout
xrandr --output DisplayPort-1 --mode 2560x1440 --pos 1200x480 --rotate normal \
       --output DisplayPort-2 --mode 1920x1200 --pos 0x0 --rotate left

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
otd-daemon &

# Start DWM
exec dwm
