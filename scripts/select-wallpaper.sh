#!/usr/bin/env bash

SELECTED=$(find $HOME/Pictures/Wallpapers -mindepth 1 -maxdepth 1 | fzf)

echo -e "set \$background '${SELECTED}'\noutput * bg \$background fill" &> $HOME/.config/sway/conf.d/wallpaper


