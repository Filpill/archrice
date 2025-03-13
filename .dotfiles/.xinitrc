#!/bin/sh

# Display Order and Scaling
xrandr --output DP-2 --primary --right-of DP-3
xrandr --output DP-2 --scale 1x1
xrandr --output DP-3 --scale 0.6x0.6

# Wallpaper Script
xwallpaper --output DP-2 --stretch $HOME/.local/src/wallpaperDL/screensaver/cowboy_bebop_spike_train.jpg
xwallpaper --output DP-3 --stretch $HOME/.local/src/wallpaperDL/screensaver/evangelion_unit01_rage.jpg

# Keyboard Properties
setxkbmap gb
xset r rate 300 50 &
sxhkd & # Key Binding Daemon

# Terminal Properties
picom -b

# Start dwm
ssh-agent dwm

# DWM Status Bar - Starts After DWM Initialises
dwmblocks
