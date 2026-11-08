{ config, lib, pkgs, pkgsUnstable, ... }:

{
  imports = [
    ./scripts/ocr.nix
  ];

  xdg.configFile."xdg-terminals.list".text = ''
    org.codeberg.dnkl.foot.desktop
  '';

  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    wl-screenrec
    imagemagick
    hyprpicker
    xdg-terminal-exec
  ] ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
    pkgsUnstable.wbg
    wlsunset
    grim
    slurp
    wmenu
    wshowkeys
  ];

  xdg.configFile."chromium-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-wayland-ime
    --wayland-text-input-version=3
    --disable-gtk-ime
    --enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE
  '';

  xdg.configFile."chrome-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-wayland-ime
    --wayland-text-input-version=3
    --disable-gtk-ime
    --enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE
  '';

  # Session identity (XDG_CURRENT_DESKTOP / XDG_SESSION_TYPE) is set by the
  # compositor so it does not leak into TTY or SSH sessions.
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    CLUTTER_BACKEND = "wayland";

    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
