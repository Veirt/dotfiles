{ ... }:

{
  imports = [
    ./base.nix
    ../modules/desktop
    ../modules/desktop/vibepanel.nix
    ../modules/desktop/vicinae.nix
    ../modules/desktop/mango-freya-shell.nix
    ../modules/native-builds.nix
    ../modules/applications/media.nix
    ../modules/applications/nautilus.nix
    ../modules/applications/system-tools.nix
    ../modules/development
  ];
}
