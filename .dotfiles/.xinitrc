#!/bin/sh

# Display Order and Scaling
xrandr --output DP-2 --primary --right-of DP-0
xrandr --output DP-2 --scale 1x1
xrandr --output DP-0 --scale 0.6x0.6
#
# Wallpaper Script
xwallpaper --output DP-2 --stretch $HOME/.local/src/wallpaperDL/screensaver/pixel_winter_cat.jpg
xwallpaper --output DP-0 --stretch $HOME/.local/src/wallpaperDL/screensaver/pixel_winter_cat.jpg

# Keyboard Properties
setxkbmap gb
xset r rate 300 50 &
sxhkd & # Key Binding Daemon

# Terminal Properties
picom -b

# Turn off screen blanking
xset s off -dpms

# Start dwm
ssh-agent dwm

# DWM Status Bar - Starts After DWM Initialises
dwmblocks
