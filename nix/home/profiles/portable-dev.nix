{ pkgs, ... }:

{
  imports = [
    ./base.nix
    ../modules/dev.nix
  ];

  home.packages = with pkgs; [
    git
    lazygit
    gh
    neovim
    tmux
    ripgrep
    fd
    jq
    direnv
    zoxide
    fzf
    nodejs
    pnpm
    go
    rustup
    python3
    uv
  ];
}
