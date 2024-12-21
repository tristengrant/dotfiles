#!/bin/bash

#xrandr --output DisplayPort-1 --primary --mode 2560x1440 --pos 1200x480 --rotate normal --output DisplayPort-2 --mode 1920x1200 --pos 0x0 --rotate left

feh --bg-fill --randomize ~/Pictures/wallpapers/* &
dunst &
udiskie &
playerctld daemon &
/usr/lib/polkit-gnome/polkit-gnome-autentication-agent-1 &

while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config ~/.config/picom/picom.conf &

# Numpad keys remapping
xremap ~/.config/xremap/config.yml --device 'HID 04f3:0635' &

# Map Caps Lock to Esc
# xmodmap -e 'keycode 66 = Escape' &
# xmodmap -e 'clear lock' &

# Wacom Intuos Pro M Settings
# Map to main display
xsetwacom set "Wacom Intuos Pro M Pen stylus" MapToOutput DisplayPort-1
xsetwacom set "Wacom Intuos Pro M Pen eraser" MapToOutput DisplayPort-1
xsetwacom set "Wacom Intuos Pro M Finger touch" MapToOutput DisplayPort-1
# Rotate the tablet pen, eraser and touch
xsetwacom set "Wacom Intuos Pro M Pen stylus" rotate half
xsetwacom set "Wacom Intuos Pro M Pen eraser" rotate half
# Turn tablet touch off
xsetwacom set "Wacom Intuos Pro M Finger touch" Touch off
# Tablet "mode"
xsetwacom set "Wacom Intuos Pro M Pen stylus" Mode "Absolute"
xsetwacom set "Wacom Intuos Pro M Pen eraser" Mode "Absolute"
xsetwacom set "Wacom Intuos Pro M Finger touch" Mode "Absolute"
# Wacom Pen buttons
xsetwacom set "Wacom Intuos Pro M Pen stylus" Button 2 "2"  # middle mouse click
xsetwacom set "Wacom Intuos Pro M Pen stylus" Button 3 "key CTRL"  # middle mouse click
# Wacom Tablet buttons
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 13 "key e" # 1 button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 12 "key b" # 2 button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 11 "key SHIFT CTRL ALT f" # 3 button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 10 "key SHIFT CTRL ALT r" # 4 button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 1 "key SHIFT o" # Ring button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 9 "key SHIFT" # 5 button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 8 "key SHIFT CTRL ALT v" # 6 button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 3 "key CTRL t" # 7 button
xsetwacom set "Wacom Intuos Pro M Pad pad" Button 2 "key CTRL d" # 8 button
# Wacom Tablet touch wheel
xsetwacom set "Wacom Intuos Pro M Pad pad" AbsWheelDown "key plus"
xsetwacom set "Wacom Intuos Pro M Pad pad" AbsWheelUp "key minus"
