{ config, lib, pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgs; [
    lazygit
    gh
    fd
    jq
    direnv
    zoxide
    fzf
    atuin
    rustup
  ] ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
    git
    tmux
    ripgrep
    nodejs
    pnpm
    pkgsUnstable.go
  ];
}
