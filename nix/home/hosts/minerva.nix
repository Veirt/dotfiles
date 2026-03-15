{ ... }:

{
  imports = [
    ../profiles/workstation.nix
  ];

  dotfiles.hostName = "minerva";
  dotfiles.root = "/home/veirt/dotfiles-hm-stow";
}
