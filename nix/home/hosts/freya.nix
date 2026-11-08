{ ... }:

{
  imports = [
    ../profiles/freya.nix
  ];

  dotfiles.root = "/home/veirt/.dotfiles";
  dotfiles.preferSystemPackages = true;
  dotfiles.initSystem = "openrc";
  dotfiles.nativeBuilds.enable = true;
  dotfiles.paths.music = "/home/veirt/personal/music";

  home.sessionVariables = {
    # The eDP panel is wired to the Intel UHD 630; VA-API must use iHD.
    LIBVA_DRIVER_NAME = "iHD";
    DEBUGINFOD_URLS = "https://debuginfod.gentoo.org";
  };
}
