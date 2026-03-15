{ config, pkgs, unstable, ... }:

let
  cliPkgs = with pkgs; [
    fzf
    zoxide
    ripgrep
    fd
    eza
    bat
    jq
    tesseract
    fastfetch
    pfetch
    ncdu
    bottom
    gotop
    powertop
    aria2
    imagemagick
    ffmpeg
    ffmpegthumbnailer
    pavucontrol
    pamixer
    brightnessctl
    batsignal
    traceroute
    dig
    nmap
    sshfs
    wireguard-tools
    yt-dlp
    act
    gallery-dl
  ];

in
{
  home.packages = cliPkgs;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    package = unstable.neovim-unwrapped;
  };

  programs.tmux.enable = true;
  programs.yazi.enable = true;
  
  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "foot";
    BROWSER = "firefox";
    TUIFM = "yazi";
  };
}
