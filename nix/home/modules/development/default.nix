{ config, lib, pkgs, pkgsUnstable, ... }:

{
  # Nix provides mise and the shell utilities needed before project runtimes
  # are activated. Language runtimes, LSPs, formatters, and dev CLIs live in
  # dev/.config/mise/config.toml.
  home.packages = [ pkgsUnstable.mise ] ++ (with pkgs; [
    fd
    jq
    direnv
    zoxide
    fzf
    atuin
  ]) ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
    pkgs.git
    pkgs.tmux
    pkgs.ripgrep
  ];

  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd --hidden --follow --exclude '.git' --exclude 'node_modules'";
    FZF_DEFAULT_OPTS = "--prompt='❱ ' --bind alt-j:down,alt-k:up";
  };

  xdg.configFile."mise/config.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.dotfiles.root}/dev/.config/mise/config.toml";
    force = true;
  };

  xdg.configFile."mise/mise.lock" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.dotfiles.root}/dev/.config/mise/mise.lock";
    force = true;
  };

  xdg.configFile."mise/locks" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.dotfiles.root}/dev/.config/mise/locks";
    force = true;
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
