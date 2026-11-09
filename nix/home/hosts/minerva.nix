{ ... }:

{
  imports = [
    ../profiles/workstation.nix
    ../modules/applications/zapfast.nix
  ];

  dotfiles.initSystem = "systemd";
  dotfiles.nativeBuilds.enable = true;

  home.sessionVariables = {
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";
    DEBUGINFOD_URLS = "https://debuginfod.archlinux.org";
  };
}
