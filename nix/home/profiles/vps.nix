{ pkgs, ... }:

{
  imports = [
    ../modules/core.nix
    ../modules/xdg-user-dirs.nix
    ../modules/env.nix
    ../modules/fish.nix
    ../modules/links.nix
  ];

  dotfiles.links.packages = [
    "shared"
    "nvim"
  ];

  home.packages = with pkgs; [
    neovim
    yazi
  ];
}
