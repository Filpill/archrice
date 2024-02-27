#!/bin/sh
# Set Resolution
#xrandr -s 1920x1080

# Wallpaper Script
#zsh ~/.local/bin/random_wallpaper.sh
xwallpaper --output Virtual-1 --stretch ~/desktop_setup/wallpaperDL/wallpaper/cartoon_cove.jpg

# DWM Status Bar Script
$HOME/.local/bin/dwmStatus.sh &

# Keyboard Properties
setxkbmap gb
xset r rate 300 50 &
sxhkd & # Key Binding Daemon

# Terminal Properties
picom -b

# Start dwm
#exec dwm
ssh-agent dwm
