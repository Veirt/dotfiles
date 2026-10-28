{ config, lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.dotfiles = {
    root = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.dotfiles";
    };

    preferSystemPackages = mkOption {
      type = types.bool;
      default = false;
      description = "Prefer host-installed packages when an equivalent system package is available.";
    };
  };

  config = {
    home.stateVersion = "24.05";

    targets.genericLinux.enable = true;
    xdg.enable = true;
    xdg.mimeApps.enable = true;
    systemd.user.startServices = "sd-switch";

    programs.home-manager.enable = true;
  };
}
