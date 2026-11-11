{ config, lib, pkgs, ... }:

{
  imports = [
    ../scripts/ocr.nix
  ];

  xdg.configFile."xdg-terminals.list".source = ../../files/desktop/xdg-terminals.list;

  home.packages = with pkgs; [
    wl-clipboard
    wl-screenrec
    imagemagick
    hyprpicker
    xdg-terminal-exec
    # Not packaged in Gentoo or guru; always come from Nix.
    wayfreeze
    wshowkeys
  ] ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
    grim
    slurp
  ];

  xdg.configFile."chromium-flags.conf".source = ../../files/desktop/chromium-flags.conf;
  xdg.configFile."chrome-flags.conf".source = ../../files/desktop/chromium-flags.conf;

  # Session identity (XDG_CURRENT_DESKTOP / XDG_SESSION_TYPE) is set by the
  # compositor so it does not leak into TTY or SSH sessions.
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    CLUTTER_BACKEND = "wayland";

    # Non-NixOS only: nixpkgs' glvnd ships no EGL vendor definitions (NixOS
    # normally bridges them via /run/opengl-driver, which does not exist here),
    # so Nix-built GL apps picked up from a keybind die with "failed to create
    # EGL display" (wdisplays and other GTK4/Qt apps hit the same wall).
    # Point glvnd at the host's vendor files so Nix apps use the system GPU
    # stack, exactly as native apps already do.
    __EGL_VENDOR_LIBRARY_FILENAMES =
      "/usr/share/glvnd/egl_vendor.d/10_nvidia.json:/usr/share/glvnd/egl_vendor.d/50_mesa.json";

    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
