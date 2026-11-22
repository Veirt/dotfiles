{ pkgsUnstable, ... }:
{
  home.packages = [ (pkgsUnstable.callPackage ./openbot-package.nix { }) ];
}
