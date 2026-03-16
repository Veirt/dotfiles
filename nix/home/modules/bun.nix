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

      if [ ${toString (builtins.length cfg.packages)} -ne 0 ]; then
        export BUN_INSTALL="${config.home.homeDirectory}/.local/share/bun"
        export PATH="$BUN_INSTALL/bin:$PATH"

        state_dir="${config.home.homeDirectory}/.local/state/dotfiles"
        state_file="$state_dir/bun-packages"
        temp_file="$(${pkgs.coreutils}/bin/mktemp)"

        trap '${pkgs.coreutils}/bin/rm -f "$temp_file"' EXIT

        ${pkgs.coreutils}/bin/mkdir -p "$BUN_INSTALL/bin" "$state_dir"
        ${pkgs.coreutils}/bin/printf '%s\n' ${concatStringsSep " " (map escapeShellArg cfg.packages)} > "$temp_file"

        if ! [ -f "$state_file" ] || ! ${pkgs.diffutils}/bin/cmp -s "$state_file" "$temp_file"; then
          ${cfg.executable} add --global ${concatStringsSep " " (map escapeShellArg cfg.packages)}
          ${pkgs.coreutils}/bin/mv "$temp_file" "$state_file"
          trap - EXIT
        fi
      fi
    '';
  };
}
