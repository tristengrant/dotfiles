# Only set these if not already defined
[ -z "$XDG_SESSION_TYPE" ] && export XDG_SESSION_TYPE=x11
[ -z "$XDG_CURRENT_DESKTOP" ] && export XDG_CURRENT_DESKTOP=DWM

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Themes and appearance
export XCURSOR_THEME=Simp1e-Gruvbox-Dark
export XCURSOR_SIZE=24
export GTK_THEME=Gruvbox-Material-Dark
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_USE_PORTAL=1

# Fixes and tweaks
export _JAVA_AWT_WM_NONREPARENTING=1  # Fix Java apps in tiling WMs
export MOZ_ENABLE_WAYLAND=0  # Force Firefox to use X11

# Path
export PATH="$HOME/Scripts:$HOME/Github:$HOME/Applications:/usr/local/sbin:/usr/local/bin:/usr/bin"
