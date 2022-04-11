#!/bin/sh

sudo pacman --needed -S git base-devel

git clone https://aur.archlinux.org/paru.git $HOME/paru
cd $HOME/paru
makepkg -si

paru -Syu --noconfirm

paru --noconfirm -S tmux \
    neovim \
    bat \
    fd \
    exa \
    fish \
    ripgrep \
    rcm
