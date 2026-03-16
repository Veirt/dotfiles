{ pkgs, lib, ... }:

{
  imports = [
    ./base.nix
    ../modules/xdg-cleanup.nix
    ../modules/bun.nix
    ../modules/desktop.nix
    ../modules/native-builds.nix
    ../modules/wayland.nix
    ../modules/theme.nix
    ../modules/dev.nix
  ];

  home.packages = with pkgs; [
    (nativeOptimized light)
    (nativeOptimized fish)
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
