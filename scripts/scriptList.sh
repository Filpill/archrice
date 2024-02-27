#!/bin/sh
folder="$HOME/.local/bin"
exec $folder/$(find $folder -type f -exec basename {} \; | dmenu)
