{ pkgs, pkgsUnstable, ... }:
{
  home.packages = [ (import ../../files/illogical-impulse/package.nix { inherit pkgs pkgsUnstable; }) ];
}
