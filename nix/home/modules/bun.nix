{ config, lib, pkgs, ... }:

let
  inherit (lib) concatStringsSep escapeShellArg mkIf mkOption types;
  cfg = config.dotfiles.bun;
in
{
  options.dotfiles.bun = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    executable = mkOption {
      type = types.str;
      default = "/usr/bin/bun";
    };

    packages = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "typescript" "@anthropic-ai/claude-code" ];
    };
  };

  config = mkIf cfg.enable {
    home.activation.installBunPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if ! [ -x ${escapeShellArg cfg.executable} ]; then
        echo "bun executable not found at ${cfg.executable}" >&2
        exit 1
      fi

      if [ ${toString (builtins.length cfg.packages)} -eq 0 ]; then
        exit 0
      fi

      export BUN_INSTALL="${config.home.homeDirectory}/.local/share/bun"
      export PATH="$BUN_INSTALL/bin:$PATH"

      ${pkgs.coreutils}/bin/mkdir -p "$BUN_INSTALL/bin"

      ${cfg.executable} add --global ${concatStringsSep " " (map escapeShellArg cfg.packages)}
    '';
  };
}
