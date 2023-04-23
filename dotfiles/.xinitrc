xrandr -s 1920x1080
setxkbmap gb
xset r rate 300 50 &
picom -b
exec dwm
sleep 1
./~/.local/bin/random_wallpaper.sh
# xwallpaper --output Virtual-1 --trim 1x1+0+0 --focus ~/wallpapers/curated/winter-sunset.jpg
