#!/bin/bash

DEVICE_PATH="/sys/bus/i2c/devices/i2c-PNP0C50:0e"
DEVICE_NAME="i2c-PNP0C50:0e"

if [ -e "$DEVICE_PATH/driver/unbind" ]; then
    echo "$DEVICE_NAME" | sudo tee "$DEVICE_PATH/driver/unbind" > /dev/null
    notify-send "Touchpad" "Disabled"
else
    echo "$DEVICE_NAME" | sudo tee /sys/bus/i2c/drivers/i2c_hid_acpi/bind > /dev/null
    notify-send "Touchpad" "Enabled"
fi
