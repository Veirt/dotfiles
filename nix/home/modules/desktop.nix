{ pkgs, pkgsUnstable, ... }:

{

  home.packages = with pkgs; [
    pkgsUnstable.mailspring

    brightnessctl
    pamixer

    (nativeOptimized pkgsUnstable.fish)
    pkgsUnstable.nixfmt
    pkgsUnstable.tinymist
    powertop
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
