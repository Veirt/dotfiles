{ pkgs, pkgsUnstable, ... }:

{
  home.packages = [
    pkgsUnstable.vicinae
    pkgs.swaybg
    (pkgs.writeShellScriptBin "vicinae-launch" ''
      export __EGL_VENDOR_LIBRARY_FILENAMES="${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
      exec ${pkgsUnstable.vicinae}/bin/vicinae "$@"
    '')
  ];
}
