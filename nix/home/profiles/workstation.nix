{ ... }:

{
  imports = [
    ./base.nix
    ../modules/desktop
    ../modules/native-builds.nix
    ../modules/applications/media.nix
    ../modules/development
  ];
}
