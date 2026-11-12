{ config, lib, pkgs, pkgsUnstable, ... }:

{
  imports = [
    ../profiles/freya.nix
    ../modules/applications/firefox-fastfox.nix
    ../modules/applications/firefox-psd.nix
    ../modules/applications/spotify.nix
    ../modules/applications/zapfast.nix
  ];

  dotfiles.preferSystemPackages = true;
  dotfiles.initSystem = "openrc";
  # The backup's gpg-private.asc is empty, so gpg-agent has no SSH key here.
  dotfiles.sshAgent = "ssh";
  dotfiles.nativeBuilds.enable = true;
  home.packages = lib.optionals (!config.dotfiles.preferSystemPackages) [
    pkgsUnstable.yazi
  ] ++ [
    pkgsUnstable.syncthing
    pkgsUnstable.gotop
    pkgsUnstable.typst
    (pkgsUnstable.texliveSmall.withPackages (tex: with tex; [
      scheme-medium collection-langchinese collection-latexextra
      collection-fontsextra collection-fontsrecommended xetex
    ]))
    pkgsUnstable.pandoc
    (pkgsUnstable.tesseract.override { enableLanguages = [ "eng" "ind" "jpn" "osd" ]; })
    pkgsUnstable.obs-studio
    pkgsUnstable.pavucontrol
    pkgsUnstable.nmap
    pkgsUnstable.tcpdump
    pkgsUnstable.iperf3
    pkgsUnstable.rclone
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
  ];

  home.file.".local/share/freya/syncthing.openrc" = {
    source = ../files/freya/syncthing.openrc;
    executable = true;
  };

  home.file.".bash_profile".source = ../files/freya/bash_profile;

  xdg.configFile."freya/login.sh".source = ../files/freya/login.sh;

  home.sessionVariables = {
    # The eDP panel is wired to the Intel UHD 630; VA-API must use iHD.
    LIBVA_DRIVER_NAME = "iHD";
    DEBUGINFOD_URLS = "https://debuginfod.gentoo.org";
  };
}
