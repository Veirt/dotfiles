{ pkgs, ... }:

{
  imports = [
    ./base.nix
  ];

  home.packages = with pkgs; [
    git
    neovim
    tmux
    ripgrep
    fd
  ];
}
