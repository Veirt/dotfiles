{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:

{

  programs.zathura = {
    enable = true;
    package =
      if config.dotfiles.preferSystemPackages then pkgs.emptyDirectory else pkgsUnstable.zathura;

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
      pkgsUnstable.vesktop

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
      pkgsUnstable.eza
      (
        if config.dotfiles.nativeBuilds.enable then
          nativeOptimized pkgsUnstable.neovim
        else
          pkgsUnstable.neovim
      )
      tesseract
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
