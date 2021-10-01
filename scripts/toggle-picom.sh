#!/usr/bin/env sh

if pgrep picom; then
    killall -q picom
else
    picom --experimental-backends -CGb
fi
