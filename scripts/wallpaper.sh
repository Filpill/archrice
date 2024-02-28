#!/bin/sh
folder="$HOME/desktop_setup/wallpaper"
xwallpaper --stretch $folder/$(find $folder -type f -exec basename {} \; | sort | dmenu)
