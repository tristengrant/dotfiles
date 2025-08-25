#!/bin/sh
slstatus &
picom --backend xrender --vsync &
feh --randomize --bg-scale ~/Pictures/wallpaper/* &
