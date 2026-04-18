{ pkgs, ... }:

{
  imports = [
    ./vps.nix
    ../modules/dev.nix
  ];
}
