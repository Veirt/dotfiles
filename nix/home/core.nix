{ config, pkgs, system, nixgl, ... }:

let
  corePkgs = with pkgs; [
    unzip
    unrar
    wget
    killall
    rsync
    lzip
    file
    stow
    libnotify
    xdg-utils
    nixgl.packages.${system}.nixGLIntel # Use nixGLMesa if on AMD or Intel; nixGLNvidia if on NVIDIA
  ];

  fontPkgs = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    source-han-sans
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

in
{
  home.packages = corePkgs ++ fontPkgs;
  fonts.fontconfig.enable = true;
}
