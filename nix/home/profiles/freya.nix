{ pkgs, lib, ... }:

{
  imports = [
    ./base.nix
    ../modules/xdg-cleanup.nix
    ../modules/desktop.nix
    ../modules/native-builds.nix
    ../modules/wayland.nix
    ../modules/waybar.nix
    ../modules/mako.nix
    ../modules/fcitx5.nix
    ../modules/media.nix
    ../modules/theme.nix
    ../modules/dev.nix
    ../modules/dev-heavy.nix
  ];

  dotfiles.links.packages = lib.mkAfter [
    "alacritty"
    "foot"
    "wayland"
    "dev"
    "system"
    "media"
  ];
}
