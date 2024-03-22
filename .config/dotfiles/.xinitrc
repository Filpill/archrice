#!/bin/sh
# Set Resolution
#xrandr -s 1920x1080

# Wallpaper Script
xwallpaper --stretch $HOME/.local/src/wallpaperDL/screensaver/cartoon_fishing_village.jpg

# Keyboard Properties
setxkbmap gb
xset r rate 300 50 &
sxhkd & # Key Binding Daemon

# Terminal Properties
picom -b

# Start dwm
#exec dwm
ssh-agent dwm

# DWM Status Bar - Starts After DWM Initialises
dwmblocks
