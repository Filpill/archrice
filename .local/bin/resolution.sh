#!/bin/sh
xrandr -s $(xrandr | dmenu | awk '{print $1}')
