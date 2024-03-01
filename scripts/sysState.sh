#!/bin/sh

case "$(printf "Shutdown\nReboot\nExit dwm\n" | dmenu -l 10 -i -p "PC Options:")" in
    "Shutdown") sudo poweroff ;;
    "Reboot") sudo reboot ;;
    "Exit dwm") pkill dwm ;;
    *) exit 1 ;;
esac
