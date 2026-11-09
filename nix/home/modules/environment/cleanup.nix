{ config, lib, ... }:

{
  xdg.cacheHome = "${config.home.homeDirectory}/.local/cache";

  xdg.configFile."wgetrc".text = "";

  home.sessionVariables = {
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
    GOPATH = "$HOME/.local/share/go";
    BUN_INSTALL = "$HOME/.local/share/bun";

    npm_config_userconfig = "$HOME/.config/npm/npmrc";
    NODE_REPL_HISTORY = "$HOME/.local/share/node_history";
    PYTHONPYCACHEPREFIX = "${config.xdg.cacheHome}/python";
    GRADLE_USER_HOME = "$HOME/.local/share/gradle";
    JAVA_TOOL_OPTIONS = "-Djava.util.prefs.userRoot=$HOME/.config/java";

    NPM_CONFIG_CACHE = "$HOME/.local/cache/npm";

    AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    AWS_CONFIG_FILE = "$HOME/.config/aws/config";
    DOCKER_CONFIG = "$HOME/.config/docker";
    GNUPGHOME = "$HOME/.config/gnupg";
    WINEPREFIX = "$HOME/.local/share/wine";

    WAKATIME_HOME = "$HOME/.config/wakatime";

    WGETRC = "$HOME/.config/wgetrc";
  };

  home.activation.createGnupgHome = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/gnupg"
    chmod 700 "$HOME/.config/gnupg"
  '';

  home.activation.createWakatimeHome = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.xdg.configHome}/wakatime"
  '';
}
