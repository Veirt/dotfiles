{ config, pkgs, ... }:

{
  # GPG Configuration
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.configHome}/gnupg";
    settings = {
      use-agent = true;
      keyid-format = "0xlong";
      with-fingerprint = true;
    };
  };

  # GPG Agent Service
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    defaultCacheTtl = 1800;
    maxCacheTtl = 7200;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # SSH Client Configuration
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    # Point SSH to use GPG agent for keys if you want to use GPG as SSH agent
    matchBlocks."*" = {
      identityAgent = "~/.gnupg/S.gpg-agent.ssh";
    };
  };

  # Ensure the socket environment variable is set for shells
  home.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
}
