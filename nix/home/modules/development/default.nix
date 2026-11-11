{ config, lib, pkgs, pkgsUnstable, ... }:

{
  # Nix provides mise and the shell utilities needed before project runtimes
  # are activated. Language runtimes, LSPs, formatters, and dev CLIs live in
  # nix/home/files/mise/config.toml.
  home.packages = [ pkgsUnstable.mise ] ++ (with pkgs; [
    jq
    unzip
    zoxide
    fzf
    atuin
  ]) ++ lib.optionals (!config.dotfiles.preferSystemPackages) [
    pkgs.fd
    pkgs.git
    pkgs.tmux
    pkgs.ripgrep
  ] ++ (with pkgsUnstable; [
    ast-grep
    hyperfine
    mprocs
    trippy
  ]);

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd --hidden --follow --exclude '.git' --exclude 'node_modules'";
    FZF_DEFAULT_OPTS = "--prompt='❱ ' --bind alt-j:down,alt-k:up";
  };

  home.file = {
    ".local/bin/cheat".source = ../../files/dev/bin/cheat;
    ".local/bin/dev-sync".source = ../../files/dev/bin/dev-sync;
    ".local/bin/j".source = ../../files/dev/bin/j;
  };

  xdg.configFile."dev-sync".source = ../../files/dev/dev-sync;

  xdg.configFile."mise/config.toml" = {
    source = ../../files/mise/config.toml;
  };

  xdg.configFile."mise/mise.lock" = {
    source = ../../files/mise/mise.lock;
  };

  xdg.configFile."mise/locks" = {
    source = ../../files/mise/locks;
  };

  xdg.configFile."lazygit/config.yml".source = ../../files/lazygit/config.yml;
}
