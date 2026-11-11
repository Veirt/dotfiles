{ pkgs, ... }:

{
  imports = [
    ../modules/core.nix
    ../modules/environment
    ../modules/shell
    ../modules/programs/git.nix
    ../modules/programs/neovim.nix
  ];

  home.packages = with pkgs; [
    neovim
    yazi
  ];
}
