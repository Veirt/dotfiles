{ config, lib, ... }:

{
  xdg.cacheHome = "${config.home.homeDirectory}/.local/cache";

  xdg.configFile."wgetrc".text = "";

  home.sessionVariables = {
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
    GOPATH = "$HOME/.local/share/go";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    BUN_INSTALL = "$HOME/.local/share/bun";

    npm_config_userconfig = "$HOME/.config/npm/npmrc";
    NODE_REPL_HISTORY = "$HOME/.local/share/node_history";
    HISTFILE = "$HOME/.local/share/bash/history";
    PYTHONPYCACHEPREFIX = "$HOME/.cache/python";
    GRADLE_USER_HOME = "$HOME/.local/share/gradle";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=$HOME/.config/java";

    NPM_CONFIG_INIT_MODULE = "$XDG_CONFIG_HOME/npm/config/npm-init.js";
    NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";

    AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    AWS_CONFIG_FILE = "$HOME/.config/aws/config";
    DOCKER_CONFIG = "$HOME/.config/docker";
    GNUPGHOME = "$HOME/.config/gnupg";
    ANDROID_USER_HOME = "$HOME/.local/share/android";
    ANDROID_HOME = lib.mkDefault "$HOME/.local/share/android";
    WINEPREFIX = "$HOME/.local/share/wine";

    WAKATIME_HOME = "$HOME/.config/wakatime";

    NSS_CONFIG_DIR = "$HOME/.config/pki/nssdb";
    WGETRC = "$HOME/.config/wgetrc";
    SUBVERSION_HOME = "$HOME/.config/subversion";
  };

  home.activation.createGnupgHome = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/gnupg"
    chmod 700 "$HOME/.config/gnupg"
  '';

  home.activation.createWakatimeHome = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$XDG_CONFIG_HOME/wakatime"
  '';
}
