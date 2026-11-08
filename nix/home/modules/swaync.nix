{ config, lib, ... }:

let
  inherit (lib) mkIf;

  # On hosts with a system swaync (Gentoo), the module would still require a
  # Nix package for its systemd unit, so write only the config files there.
  useSystemPackage = config.dotfiles.preferSystemPackages;

  configFile = ../../../wayland/.config/swaync/config.json;
  styleFile = ../../../wayland/.config/swaync/style.css;
in
{
  services.swaync = mkIf (!useSystemPackage) {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile configFile);
    style = builtins.readFile styleFile;
  };

  xdg.configFile = mkIf useSystemPackage {
    "swaync/config.json".source = configFile;
    "swaync/style.css".source = styleFile;
  };
}
