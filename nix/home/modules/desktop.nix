{ config, lib, pkgs, pkgsUnstable, ... }:

{

  programs.zathura = {
    enable = true;
    package = if config.dotfiles.preferSystemPackages then pkgs.emptyDirectory else pkgsUnstable.zathura;

    options = {
      selection-clipboard = "clipboard";
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    pkgsUnstable.mailspring
    pkgsUnstable.vesktop

    pkgsUnstable.eza

    brightnessctl
    pamixer
    pkgsUnstable.mpd-discord-rpc

    batsignal

    libnotify
    pkgsUnstable.swayosd

    (nativeOptimized pkgsUnstable.neovim)
    pkgsUnstable.nixfmt
    pkgsUnstable.tinymist

    pkgs.corefonts
  ] ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
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
