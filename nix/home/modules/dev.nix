{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    lazygit
    gh
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
  ];
}
