{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "ocr" ''
      set -euo pipefail

      if [ "''${XDG_SESSION_TYPE:-}" != "wayland" ]; then
        printf '%s\n' "ocr requires a Wayland session" >&2
        exit 1
      fi

      text="$(
        grim -g "$(slurp)" - \
          | tesseract -l "ind+eng+jpn" stdin stdout
      )"

      printf '%s' "$text" | wl-copy
      notify-send "OCR" "Copied recognized text to clipboard"
      printf '%s\n' "$text"
    '')
  ];
}
