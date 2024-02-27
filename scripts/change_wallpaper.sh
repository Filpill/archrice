#!/bin/sh
folder="$HOME/desktop_setup/wallpaper"
#ln -sf "$(find $folder -type f | sort -n | xargs -r0 | dmenu -l 15 -p chwall)" $folder
xwallpaper --stretch $folder/$(find $folder -type f -exec basename {} \; | dmenu)
    #awk '{print $folder/$1}' #xwallpaper --stretch
