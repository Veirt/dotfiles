{ ... }:

{
  imports = [
    ../profiles/workstation.nix
  ];

  dotfiles.root = "/home/veirt/.dotfiles";
  dotfiles.initSystem = "systemd";
  dotfiles.nativeBuilds.enable = true;

  home.sessionVariables = {
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";
    DEBUGINFOD_URLS = "https://debuginfod.archlinux.org";
  };
}
