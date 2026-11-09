{ lib, ... }:

{
  imports = [
    ./base.nix
    ../modules/xdg-cleanup.nix
    ../modules/mime-apps.nix
    ../modules/desktop.nix
    ../modules/fcitx5.nix
    ../modules/native-builds.nix
    ../modules/wayland.nix
    ../modules/waybar.nix
    ../modules/swaync.nix
    ../modules/media.nix
    ../modules/theme.nix
    ../modules/development
  ];

  dotfiles.links.packages = lib.mkAfter [
    "alacritty"
    "foot"
    "wayland"
    "mangowc"
  ];
}
