{ config, pkgs, unstable, ... }:

{
  imports = [
    ./core.nix
    ./shell.nix
    ./desktop.nix
    ./dev.nix
    ./media.nix
    ./security.nix
  ];

  home.username = "veirt";
  home.homeDirectory = "/home/veirt";
  home.stateVersion = "24.05";

  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mimeApps.enable = true;
  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    # 1. Wayland / Graphics
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    CLUTTER_BACKEND = "wayland";

    # 2. XDG Base Directory Specification
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    XDG_CACHE_HOME  = "$HOME/.cache";

    # 3. Development Tools (XDG Redirections)
    # Rust
    CARGO_HOME      = "$HOME/.local/share/cargo";
    RUSTUP_HOME     = "$HOME/.local/share/rustup";
    # Go
    GOPATH          = "$HOME/.local/share/go";
    # Node / NPM
    npm_config_userconfig = "$HOME/.config/npm/npmrc";
    NODE_REPL_HISTORY     = "$HOME/.local/share/node_history";
    # Python
    PYTHONSTARTUP   = "$HOME/.config/python/pythonrc";
    PYTHONPYCACHEPREFIX = "$HOME/.cache/python";
    # Java / Gradle
    GRADLE_USER_HOME = "$HOME/.local/share/gradle";
    _JAVA_OPTIONS    = "-Djava.util.prefs.userRoot=$HOME/.config/java";
    
    # 4. Infrastructure & CLI
    AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    AWS_CONFIG_FILE             = "$HOME/.config/aws/config";
    DOCKER_CONFIG               = "$HOME/.config/docker";
    GNUPGHOME                   = "$HOME/.config/gnupg";
    ANDROID_USER_HOME           = "$HOME/.local/share/android";
    ANDROID_HOME                = "$HOME/.local/share/android";
    WINEPREFIX                  = "$HOME/.local/share/wine";
    
    # 5. Persistent "Stubborn" Redirections (from XDG-Ninja)
    # PKI/NSS
    NSS_CONFIG_DIR              = "$HOME/.config/pki/nssdb";
    # Wget
    WGETRC                      = "$HOME/.config/wgetrc";
    # Gradle
    GRADLE_USER_HOME            = "$HOME/.local/share/gradle";
    # X11 / Cursors
    XCURSOR_PATH                = "/usr/share/icons:$HOME/.local/share/icons";
    # Subversion
    SUBVERSION_HOME             = "$HOME/.config/subversion";

    # 6. Default Applications
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "foot";
    BROWSER = "firefox";
    TUIFM = "yazi";
    GUIFM = "nautilus";
  };

  # 6. Stubborn Tools (Tools that need aliases to behave)
  home.shellAliases = {
    # Force tools to use XDG paths if they don't respect env vars
    adb = "adb -a"; # Often needs specific flags for certain setups
    # Add any others here as you find them
  };

}
