#!/usr/bin/bash

BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PCT=$(echo $BRIGHTNESS $MAX_BRIGHTNESS | awk '{printf "%4.0f\n",($1/$2)*100}' | tr -d '[:space:]')

# Send the notification with the icon:
notify-send.sh "Brightness ${PCT}%" \
    --replace-file=/tmp/brightness-notification \
    -t 2000 \
    --icon ~/.icons/brightness.png \
    -h int:value:${PCT} \
    -h string:synchronous:brightness-change
