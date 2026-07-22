{ pkgs, pkgsUnstable, ... }:

{
  imports = [
    ./scripts/ocr.nix
  ];

  xdg.configFile."xdg-terminals.list".text = ''
    org.codeberg.dnkl.foot.desktop
  '';

  home.packages = with pkgs; [
    pkgsUnstable.wbg

    grim
    slurp
    wl-clipboard
    wl-screenrec
    wlsunset
    wmenu
    imagemagick
    wshowkeys
    hyprpicker
    xdg-terminal-exec
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

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "wlroots";
    XDG_SESSION_DESKTOP = "wlroots";

    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland,x11";

    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
