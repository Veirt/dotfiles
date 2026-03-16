{ ... }:

{
  xdg.configFile."xdg-terminals.list".text = ''
    org.codeberg.dnkl.foot.desktop
  '';

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
    SDL_VIDEODRIVER = "wayland";

    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";

    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";

    _JAVA_AWT_WM_NONREPARENTING = "1";
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";
  };
}
