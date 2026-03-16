{ ... }:

{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    CLUTTER_BACKEND = "wayland";

    TERMINAL = "foot";
    BROWSER = "firefox";
    GUIFM = "nautilus";
    TUIFM = "yazi";

    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XDG_CURRENT_DESKTOP = "wlroots";
    XDG_SESSION_DESKTOP = "wlroots";
    MOZ_WEBRENDER = "1";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    CHROME_EXECUTABLE = "google-chrome-stable";
    PF_INFO = "ascii os wm uptime pkgs memory palette";
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";
  };
}
