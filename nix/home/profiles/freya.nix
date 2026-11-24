{ ... }:

{
  imports = [
    ./base.nix
    ../modules/desktop
    ../modules/native-builds.nix
    ../modules/applications/media.nix
    ../modules/applications/nautilus.nix
    ../modules/applications/system-tools.nix
    ../modules/development
  ];
}
