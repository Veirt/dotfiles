{ config, lib, pkgs, pkgsUnstable, ... }:

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
    pkgsUnstable.wgo
    pkgsUnstable.devbox
    pkgsUnstable.ansible
    terraform
  ] ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
    pkgsUnstable.just
    pkgsUnstable.gotop
    pkgsUnstable.pyright
  ];

  dotfiles.bun = {
    enable = true;
    executable = "/usr/bin/bun";
    packages = [
      "9router@0.5.104"
      "@agegr/pi-web@0.12.2"
      "@charmland/crush@0.98.1"
      "@earendil-works/pi-ai@1.3.0"
      "@earendil-works/pi-coding-agent@1.3.0"
      "@oh-my-pi/pi-coding-agent@18.11.3"
      "@typescript/native-preview@7.0.0-dev.20260707.2"
      "@vtsls/language-server@0.3.0"
      "cline@3.0.73"
      "command-code@1.84.0"
      "context-mode@1.0.169"
      "ctx7@0.8.0"
      "effect-solutions@0.5.3"
      "emmet-language-server@0.1.3"
      "intelephense@1.18.5"
      "lefthook@2.2.2"
      "oxfmt@0.73.0"
      "oxlint@1.88.0"
      "pyright@1.1.414"
      "svelte-language-server@0.18.5"
      "typescript@7.0.2"
      "typescript-language-server@6.0.2"
      "vscode-langservers-extracted@4.10.0"
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
        description: 'Generate AI commit'
        command: 'tiredcommit'
        context: 'files'
        output: 'terminal'
  '';
}
