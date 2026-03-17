{ pkgs, pkgsUnstable, ... }:

{
  imports = [
    ./bun.nix
  ];

  home.packages = with pkgs; [
    black
    google-cloud-sdk
    gopls
    hadolint
    isort
    lua-language-server
    prettypst
    stylua
    texlab
    pkgsUnstable.uv
    pkgsUnstable.just
    pkgsUnstable.wgo
    pkgsUnstable.gotop
  ];

  dotfiles.bun = {
    enable = true;
    executable = "/usr/bin/bun";
    packages = [
      "@biomejs/biome"
      "@fsouza/prettierd"
      "@vtsls/language-server"
      "aicommit2"
      "context-mode"
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
    FZF_DEFAULT_OPTS = "--prompt='❱ ' --bind alt-j:down,alt-k:up";
  };

  xdg.configFile."lazygit/config.yml".text = ''
    git:
      overrideGpg: true
    customCommands:
      - key: '<c-b>'
        description: 'Generate AI commit (aicommit2)'
        command: 'aicommit2'
        context: 'files'
        output: 'terminal'
  '';
}
