{ config, pkgs, unstable, ... }:

let
  mediaPkgs = with pkgs; [
    mpv
    mpd
    unstable.mpd-discord-rpc
    mpc-cli
    ncmpcpp
    picard
    easyeffects
  ];

  gamingPkgs = with pkgs; [
    winetricks
    wineWowPackages.waylandFull
    protonup
    lutris
    prismlauncher
  ];

in
{
  home.packages = mediaPkgs ++ gamingPkgs;
}
