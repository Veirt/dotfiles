{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "colorpicker" ''
      set -euo pipefail

      if [ "''${XDG_SESSION_TYPE:-}" != "wayland" ]; then
        printf '%s\n' "colorpicker requires a Wayland session" >&2
        exit 1
      fi

      grim -g "$(slurp -p)" -t ppm - \
        | magick convert - -format '%[pixel:p{0,0}]' txt:- \
        | tail -n 1 \
        | cut -d ' ' -f 4 \
        | tr -d '[:space:]' \
        | wl-copy
    '')
  ];
}
