#!/usr/bin/env bash

bluetoothctl power on

SELECTED_DEVICE=$(bluetoothctl devices | fzf)

if [ -z "$SELECTED_DEVICE" ]; then
    echo "Please select a device."
    exit 1

else
    bluetoothctl connect $(echo $SELECTED_DEVICE | grep -Po '\s(\w+:?)+\s' | xargs)
fi


