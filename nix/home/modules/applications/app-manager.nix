{ config, inputs, pkgs, ... }:

{
  home.packages = [ inputs.app-manager.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  dconf.settings."com/github/AppManager" = {
    applications-dir = "${config.home.homeDirectory}/apps";
  };
}
