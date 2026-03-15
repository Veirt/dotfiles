{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf mkOption types;
in
{
  options.dotfiles.secrets = {
    enable = mkEnableOption "sops-nix secret management";

    ageKeyFile = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };

    sopsFile = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };

  config = mkIf config.dotfiles.secrets.enable {
    assertions = [
      {
        assertion = config.dotfiles.secrets.sopsFile != null;
        message = "Set dotfiles.secrets.sopsFile before enabling sops-nix.";
      }
    ];

    sops = {
      age.keyFile = config.dotfiles.secrets.ageKeyFile;
      defaultSopsFile = config.dotfiles.secrets.sopsFile;
    };
  };
}
