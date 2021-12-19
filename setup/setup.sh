#!/usr/bin/env bash

## SETUP yay
sudo pacman --needed -S git base-devel

git clone https://aur.archlinux.org/yay-bin.git $HOME/yay
cd $HOME/yay
makepkg -si

yay -Syu --noconfirm

yay --noconfirm -S tmux \
    neovim \
    bat \
    fd \
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
