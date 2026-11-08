{ pkgsUnstable, ... }:

{
  imports = [
    ../profiles/freya.nix
  ];

  dotfiles.root = "/home/veirt/.dotfiles";
  dotfiles.preferSystemPackages = true;
  dotfiles.initSystem = "openrc";
  # The backup's gpg-private.asc is empty, so gpg-agent has no SSH key here.
  dotfiles.sshAgent = "ssh";
  dotfiles.nativeBuilds.enable = true;
  dotfiles.bun.executable = "${pkgsUnstable.bun}/bin/bun";

  home.packages = [ pkgsUnstable.bun ];

  home.sessionVariables = {
    # The eDP panel is wired to the Intel UHD 630; VA-API must use iHD.
    LIBVA_DRIVER_NAME = "iHD";
    DEBUGINFOD_URLS = "https://debuginfod.gentoo.org";
  };
}
