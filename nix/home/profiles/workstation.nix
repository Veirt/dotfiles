{ pkgs, lib, ... }:

{
  imports = [
    ./base.nix
    ../modules/xdg-cleanup.nix
    ../modules/bun.nix
    ../modules/desktop.nix
    ../modules/dev.nix
    ../modules/spotify.nix
  ];

  home.packages = with pkgs; [
    light
  ];

  dotfiles.links.packages = lib.mkAfter [
    "alacritty"
    "foot"
    "sway"
    "fcitx5"
    "mpv"
    "mpd"
    "ncmpcpp"
  ];
}
