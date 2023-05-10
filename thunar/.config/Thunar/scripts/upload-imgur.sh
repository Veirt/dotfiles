#!/bin/bash

imgur.sh "$1" | head -n 1 | wl-copy
notify-send "Imgur link copied to clipboard"
