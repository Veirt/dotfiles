{ ... }:

{
  imports = [
    ../profiles/freya.nix
  ];

  dotfiles.root = "/home/veirt/.dotfiles";
  dotfiles.preferSystemPackages = true;

  home.sessionVariables = {
    VDPAU_DRIVER = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
