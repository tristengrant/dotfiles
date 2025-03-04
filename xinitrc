# Set DPI (adjust as needed)
xrandr --dpi 96

# Set Monitor Layout
xrandr --output DisplayPort-1 --mode 2560x1440 --pos 1200x480 --rotate normal --output DisplayPort-2 --mode 1920x1200 --pos 0x0 --rotate left

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
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
clipster -d 2>/dev/null &
mpd &

# Load ~/.profile if it exists
[ -f ~/.profile ] && . ~/.profile

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
[ ! -d "$XDG_RUNTIME_DIR" ] && mkdir -p "$XDG_RUNTIME_DIR" && chmod 700 "$XDG_RUNTIME_DIR"

#Start DWM
#exec dwm
