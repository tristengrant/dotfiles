# Set DPI (adjust as needed)
xrandr --dpi 96

# Set Monitor Layout
xrandr --output DisplayPort-1 --mode 2560x1440 --pos 1200x480 --rotate normal --output DisplayPort-2 --mode 1920x1200 --pos 0x0 --rotate left

# Load environment variables from ~/.profile
[ -f ~/.profile ] && source ~/.profile

# Load environment variables from ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set default cursor
xsetroot -cursor_name left_ptr  # Set default cursor

# Start background applications
feh --bg-fill --randomize ~/Pictures/wallpapers/* &
dwmblocks &
dunst &
udiskie &
syncthing-gtk --hidden &
#picom --experimental-backends -b
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
clipster -d 2>/dev/null &

#Start DWM
exec dwm
