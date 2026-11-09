{ config, lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.dotfiles = {
    preferSystemPackages = mkOption {
      type = types.bool;
      default = false;
      description = "Prefer host-installed packages when an equivalent system package is available.";
    };

    initSystem = mkOption {
      type = types.enum [ "systemd" "openrc" ];
      default = "systemd";
      description = "Host init system; gates systemd-only integrations.";
    };

    sshAgent = mkOption {
      type = types.enum [ "gpg" "ssh" ];
      default = "gpg";
      description = "Where SSH_AUTH_SOCK should point.";
    };

    nativeBuilds.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Opt in to rebuilding selected packages with -O3 -march=native.";
    };

    paths.music = mkOption {
      type = types.str;
      default = "/mnt/storage/music";
      description = "Music library path used by MPD.";
    };
  };

  config = {
    home.stateVersion = "24.05";

    targets.genericLinux.enable = true;
    xdg.enable = true;
    xdg.mimeApps.enable = true;

    # systemd user services do not exist under OpenRC.
    systemd.user.startServices =
      if config.dotfiles.initSystem == "systemd" then "sd-switch" else false;

    programs.home-manager.enable = true;
  };
}
