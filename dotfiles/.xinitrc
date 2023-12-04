#!/bin/sh
# Set Resolution
#xrandr -s 1920x1080

# Wallpaper sript
zsh ~/.local/bin/random_wallpaper.sh

# Keyboard Properties
setxkbmap gb
xset r rate 300 50 &
sxhkd & # Key Binding Daemon

# Terminal Properties
picom -b

# Start dwm
exec dwm
