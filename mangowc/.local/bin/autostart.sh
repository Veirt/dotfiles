#! /bin/bash

set +e

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
/usr/lib/xdg-desktop-portal-wlr &

# # notify
# swaync &
#
# # night light
# wlsunset -T 3501 -t 3500 &
#
# # wallpaper
# swaybg -i ~/.config/mango/wallpaper/room.png &
#
# # top bar
# waybar -c ~/.config/mango/waybar/config -s ~/.config/mango/waybar/style.css &
#
# # keep clipboard content
# wl-clip-persist --clipboard regular --reconnect-tries 0 &
#
# # clipboard content manager
# wl-paste --type text --watch cliphist store & 
#
# # xwayland dpi scale
# echo "Xft.dpi: 140" | xrdb -merge #dpi缩放
# gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
#
# # Permission authentication
# /usr/lib/xfce-polkit/xfce-polkit &

