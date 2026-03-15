{ config, lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.dotfiles = {
    hostName = mkOption {
      type = types.str;
      default = "generic";
    };

    root = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.dotfiles";
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
