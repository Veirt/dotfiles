{ ... }:

{
  imports = [
    ../profiles/workstation.nix
  ];

  dotfiles.root = "/home/veirt/.dotfiles";
}
