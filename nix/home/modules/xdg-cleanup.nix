{ ... }:

{
  home.sessionVariables = {
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
    GOPATH = "$HOME/.local/share/go";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    BUN_INSTALL = "$HOME/.local/share/bun";

    npm_config_userconfig = "$HOME/.config/npm/npmrc";
    NODE_REPL_HISTORY = "$HOME/.local/share/node_history";
    PYTHONSTARTUP = "$HOME/.config/python/pythonrc";
    PYTHONPYCACHEPREFIX = "$HOME/.cache/python";
    GRADLE_USER_HOME = "$HOME/.local/share/gradle";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=$HOME/.config/java";

    AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    AWS_CONFIG_FILE = "$HOME/.config/aws/config";
    DOCKER_CONFIG = "$HOME/.config/docker";
    GNUPGHOME = "$HOME/.config/gnupg";
    ANDROID_USER_HOME = "$HOME/.local/share/android";
    ANDROID_HOME = "$HOME/.local/share/android";
    WINEPREFIX = "$HOME/.local/share/wine";

    NSS_CONFIG_DIR = "$HOME/.config/pki/nssdb";
    WGETRC = "$HOME/.config/wgetrc";
    SUBVERSION_HOME = "$HOME/.config/subversion";
  };
}
