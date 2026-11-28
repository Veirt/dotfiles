{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:

let
  systemVesktop = pkgs.writeShellScriptBin "vesktop" ''
    unset LIBVA_DRIVERS_PATH
    if [ -n "''${WAYLAND_DISPLAY:-}" ]; then
      exec /usr/bin/vesktop-bin \
        --ozone-platform-hint=auto \
        --enable-features=WaylandWindowDecorations \
        --enable-wayland-ime=true \
        "$@"
    fi
    exec /usr/bin/vesktop-bin "$@"
  '';
in
{

  programs.zathura = {
    enable = true;
    package = pkgsUnstable.zathura;

    options = {
      selection-clipboard = "clipboard";
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "0xProto Nerd Font" ];
  };

  home.packages =
    with pkgs;
    [
      pkgsUnstable.mailspring

      brightnessctl
      pamixer

      batsignal

      libnotify

      pkgsUnstable.nixfmt
      pkgsUnstable.tinymist

      pkgs.corefonts
      pkgs.nerd-fonts._0xproto
    ]
    ++ lib.optionals (config.dotfiles.initSystem == "systemd") [
      pkgsUnstable.mpd-discord-rpc
    ]
    ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
      pkgsUnstable.vesktop
      pkgsUnstable.eza
      (
        if config.dotfiles.nativeBuilds.enable then
          nativeOptimized pkgsUnstable.neovim
        else
          pkgsUnstable.neovim
      )
      tesseract
    ]
    ++ lib.optionals config.dotfiles.preferSystemPackages [
      systemVesktop
    ];

  home.sessionVariables = {
    TERMINAL = "foot";
    BROWSER = "firefox";
    GUIFM = "nautilus";
    TUIFM = "yazi";

    CHROME_EXECUTABLE = "google-chrome-stable";
    PF_INFO = "ascii os wm uptime pkgs memory palette";
  };
}
