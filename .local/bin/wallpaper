#!/bin/sh
folder="$HOME/.local/src/wallpaperDL/screensaver"
xwallpaper --stretch $folder/$(find $folder -type f -exec basename {} \; | sort | dmenu)
