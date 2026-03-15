{ config, pkgs, unstable, lib, system, nixgl, ... }:

let
  # Choose the correct nixGL wrapper for AMD/Mesa (CachyOS)
  nixGL = nixgl.packages.${system}.nixGLIntel;

  # Helper function to wrap GUI apps for graphics compatibility on Arch
  mkGLApp = { name, pkg, bin ? name }:
    pkgs.writeShellScriptBin name ''
      exec ${lib.getExe nixGL} ${pkg}/bin/${bin} "$@"
    '';

  desktopPkgs = with pkgs; [
    # mangowc companions
    waybar
    mako
    foot
    wlsunset
    grim
    slurp
    wmenu
    wshowkeys
    wl-clipboard
    kanshi
    swaylock
    wofi
    ulauncher
    wf-recorder
    wl-mirror
    playerctl
    zathura
    
    # Customization
    orchis-theme
    tela-icon-theme
    gnome-tweaks
  ];

  # Wrapped GUI Apps
  guiApps = [
    (mkGLApp { name = "obsidian"; pkg = pkgs.obsidian; })
    (mkGLApp { name = "discord";  pkg = pkgs.discord; })
    (mkGLApp { name = "vesktop";  pkg = pkgs.vesktop; })
    (mkGLApp { name = "webcord";  pkg = pkgs.webcord; })
    (mkGLApp { name = "bruno";    pkg = pkgs.bruno; })
    (mkGLApp { name = "zed";      pkg = unstable.zed-editor; })
  ];

  standaloneApps = with pkgs; [
    firefox
    google-chrome
    chromium
    unstable.android-studio
    android-tools
    scrcpy
    mailspring
    betterbird
    postman
    beekeeper-studio
    remmina
    gthumb
    nautilus
    libreoffice-qt6-still
    evince
    totem
  ];

in
{
  home.packages = desktopPkgs ++ guiApps ++ standaloneApps;

  # Theming & UI Fixes
  home.sessionVariables = {
    GTK_THEME = "Orchis-Grey-Dark-Compact";
    GUIFM = "nautilus";
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";
  };

  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-mozc
    ];
  };
}
