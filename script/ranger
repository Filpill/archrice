#!/bin/bash
user="filpill"
display="Virtual-1"
folder=(~/wallpapers/curated/)
wallpaper=$( ls $folder | shuf -n 1) #randomised wallpaper
echo "Setting Wallpaper to $wallpaper"
xwallpaper --output $display --stretch $folder$wallpaper
