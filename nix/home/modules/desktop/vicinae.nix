{ pkgs, pkgsUnstable, ... }:

let
  # vicinae is a nix-built Qt 6 app, so its loader only searches the nix store
  # and never finds the host EGL vendor drivers in /usr/lib64. Qt then aborts
  # with "Failed to initialize graphics backend for OpenGL". Point EGL at nix
  # mesa instead so OpenGL works without going through a separate launcher.
  vicinae = pkgs.symlinkJoin {
    name = "vicinae";
    paths = [ pkgsUnstable.vicinae ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/vicinae \
        --set __EGL_VENDOR_LIBRARY_FILENAMES "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
    '';
  };
in
{
  home.packages = [
    vicinae
    pkgs.swaybg
  ];

  xdg.configFile."vicinae/settings.json".source = ../../files/vicinae/settings.json;
}
