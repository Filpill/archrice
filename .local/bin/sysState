#!/bin/sh

case "$(printf "Shutdown\nReboot\nExit to tty\n" | dmenu -l 10 -i -p "PC Options:")" in
    "Shutdown") sudo poweroff ;;
    "Reboot") sudo reboot ;;
    "Exit to tty") killall xinit;;
    *) exit 1 ;;
esac
