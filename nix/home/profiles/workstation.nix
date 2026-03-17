{ pkgs, pkgsUnstable, lib, ... }:

{
  imports = [
    ./base.nix
    ../modules/android.nix
    ../modules/xdg-cleanup.nix
    ../modules/bun.nix
    ../modules/desktop.nix
    ../modules/fcitx5.nix
    ../modules/native-builds.nix
    ../modules/wayland.nix
    ../modules/theme.nix
    ../modules/dev.nix
  ];

  home.packages = with pkgs; [
    (nativeOptimized light)
    (nativeOptimized pkgsUnstable.fish)
    cpupower-gui
  ];

  dotfiles.links.packages = lib.mkAfter [
    "alacritty"
    "foot"
    "sway"
    "mpv"
    "mpd"
    "ncmpcpp"
  ];
}
