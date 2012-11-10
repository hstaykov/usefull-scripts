#!/bin/bash

declare -r pad="PS/2 Generic Mouse"

pad_status=$(xinput --list-props "$pad" | grep "Device Enabled")
is_pad_enabled=$(expr substr "$pad_status" ${#pad_status} 1)

if [[ 1 == $is_pad_enabled ]]; then
    echo -ne "\nDisabling touchpad...\t"
    xinput --set-prop "PS/2 Generic Mouse" "Device Enabled" 0
    echo -ne "OK\n\n"
else 
    echo -ne "\nEnabling touchpad...\t"
    xinput --set-prop "PS/2 Generic Mouse" "Device Enabled" 1 
    echo -ne "OK\n\n" 
fi
