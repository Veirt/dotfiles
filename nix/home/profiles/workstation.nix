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
    ../modules/bun.nix
    ../modules/desktop.nix
    ../modules/fcitx5.nix
    ../modules/native-builds.nix
    ../modules/wayland.nix
    ../modules/theme.nix
    ../modules/dev.nix
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "image/png" = [ "org.gnome.gThumb.desktop" ];
      "image/jpeg" = [ "org.gnome.gThumb.desktop" ];
    };
  };

  dotfiles.links.packages = lib.mkAfter [
    "alacritty"
    "foot"
    "sway"
    "mpv"
    "mpd"
    "ncmpcpp"
  ];
}
