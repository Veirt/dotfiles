{ ... }:

{
  imports = [
    ../modules/core.nix
    ../modules/environment
    ../modules/shell
    ../modules/programs
    ../modules/secrets.nix
    ../modules/security.nix
  ];
}
