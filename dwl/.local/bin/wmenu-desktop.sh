#!/usr/bin/env bash

chosen=$(find /usr/share/applications ~/.local/share/applications -type f -name "*.desktop" \
  | sed 's#.*/##;s#.desktop$##' \
  | wmenu -p "Launch:")

if [ -n "$chosen" ]; then
    desktop-file-install --rebuild-mime-info-cache
    gtk-launch "$chosen"
fi

