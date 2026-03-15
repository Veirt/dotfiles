{ config, pkgs, unstable, ... }:

let
  devPkgs = with pkgs; [
    # Toolchains
    gcc
    gnumake
    pkg-config
    openssl
    
    # Languages
    nodejs
    pnpm
    unstable.bun
    deno
    rustup
    cargo-watch
    cargo-bump
    go
    wgo
    python3
    pipx
    uv
    php
    php82Packages.composer
    git-repo
    
    # Infrastructure
    terraform
    awscli2
    google-cloud-sdk
    docker-buildx
    
    # Tooling
    git
    gh
    lazygit
    gnupg
    just
    mods
    tree-sitter
    luarocks
    lua
  ];

in
{
  home.packages = devPkgs;
}
