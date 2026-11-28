{ config, lib, pkgs, pkgsUnstable, ... }:

let
  nbfcLinux = pkgsUnstable.nbfc-linux.overrideAttrs (old: {
    configureFlags = (old.configureFlags or [ ]) ++ [
      "--sysconfdir=/etc"
      "--runstatedir=/run"
    ];
    installFlags = [ "sysconfdir=${placeholder "out"}/etc" ];
  });

  wlScreenrec = lib.hiPrio (pkgs.writeShellScriptBin "wl-screenrec" ''
    export LIBVA_DRIVERS_PATH="${pkgs.intel-media-driver}/lib/dri"
    exec ${pkgs.wl-screenrec}/bin/wl-screenrec "$@"
  '');
in
{
  imports = [
    ../profiles/freya.nix
    ../modules/applications/app-manager.nix
    ../modules/applications/firefox-fastfox.nix
    ../modules/applications/firefox-psd.nix
    ../modules/applications/openbot.nix
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
    pkgsUnstable.prometheus-node-exporter
    nbfcLinux
    wlScreenrec
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts
  ];

  home.file.".local/share/freya/nbfc.json".source = ../files/freya/nbfc.json;
  home.file.".local/share/freya/nbfc-an515-52.json".source = ../files/freya/nbfc-an515-52.json;

  home.file.".local/share/freya/nbfc-service.openrc" = {
    source = ../files/freya/nbfc-service.openrc;
    executable = true;
  };

  home.file.".local/bin/fan" = {
    source = ../files/freya/fan;
    executable = true;
  };

  home.file.".local/share/freya/syncthing.openrc" = {
    source = ../files/freya/syncthing.openrc;
    executable = true;
  };

  home.file.".local/share/freya/node-exporter.openrc" = {
    source = ../files/freya/node-exporter.openrc;
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
