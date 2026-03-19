{ ... }:

{
  imports = [
    ../modules/core.nix
    ../modules/xdg-user-dirs.nix
    ../modules/env.nix
    ../modules/links.nix
    ../modules/shell.nix
    ../modules/secrets.nix
    ../modules/security.nix
  ];

  dotfiles.links.packages = [
    "shared"
    "bash"
    "fish"
    "nvim"
    "tmux"
    "xdg"
  ];
}
