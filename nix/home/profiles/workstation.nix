{
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:

{
  imports = [
    ./base.nix
    ../modules/xdg-cleanup.nix
    ../modules/mime-apps.nix
    ../modules/bun.nix
    ../modules/desktop.nix
    ../modules/fcitx5.nix
    ../modules/native-builds.nix
    ../modules/wayland.nix
    ../modules/waybar.nix
    ../modules/swaync.nix
    ../modules/media.nix
    ../modules/theme.nix
    ../modules/dev.nix
    ../modules/dev-heavy.nix
  ];

  dotfiles.links.packages = lib.mkAfter [
    "alacritty"
    "foot"
    "wayland"
    "mangowc"
  ];
}
