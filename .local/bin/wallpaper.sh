#!/bin/sh
folder="$HOME/desktop_setup/wallpaperDL/screensaver"
xwallpaper --stretch $folder/$(find $folder -type f -exec basename {} \; | sort | dmenu)
