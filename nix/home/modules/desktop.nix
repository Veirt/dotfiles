{ pkgs, pkgsUnstable, ... }:

{

  programs.zathura = {
    enable = true;
    package = pkgsUnstable.zathura;

    options = {
      selection-clipboard = "clipboard";
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    pkgsUnstable.mailspring

    brightnessctl
    pamixer
    pkgsUnstable.mpd-discord-rpc

    (nativeOptimized pkgsUnstable.neovim)
    pkgsUnstable.nixfmt
    pkgsUnstable.tinymist
    powertop

    pkgs.corefonts
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
