#!/bin/sh
desktop="DESKTOP-R1B3P7P"
windows_folder="vm_share_folder"
linux_folder="/mnt/Hyper-V"
desktop_ip=$(nmblookup $desktop | head -n 1 | cut -d ' ' -f 1)
mount -t cifs //$desktop/$windows_folder $linux_folder -o,ip=$desktop_ip
