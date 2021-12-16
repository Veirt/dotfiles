#!/usr/bin/env bash

if (($EUID != 0)); then
    echo "Please run this script as root."
    exit 1
fi

## SETUP yay

git clone https://aur.archlinux.org/yay.git $HOME/yay
cd yay
makepkg -si

sudo yay -Syu --noconfirm

yay --noconfirm -S tmux \
    neovim \
    bat \
    ncmpcpp \
    i3-gaps \
    picom \
    starship \
    dunst \
    fish \
    polybar \
    kitty \
    ripgrep \
    rcm
