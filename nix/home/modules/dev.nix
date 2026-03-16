{ pkgs, ... }:

{
  imports = [
    ./bun.nix
  ];

  home.packages = with pkgs; [
    black
    gopls
    hadolint
    isort
    lua-language-server
    prettypst
    stylua
    texlab
  ];

  dotfiles.bun = {
    enable = true;
    executable = "/usr/bin/bun";
    packages = [
      "@biomejs/biome"
      "@fsouza/prettierd"
      "@vtsls/language-server"
      "emmet-language-server"
      "eslint"
      "eslint_d"
      "intelephense"
      "oxfmt"
      "oxlint"
      "prettier"
      "rustywind"
      "typescript"
      "typescript-language-server"
      "vscode-langservers-extracted"
    ];
  };

  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd --hidden --follow --exclude '.git' --exclude 'node_modules'";
    FZF_DEFAULT_OPTS = "--bind alt-j:down,alt-k:up";
  };
}
