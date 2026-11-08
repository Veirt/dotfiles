{ config, lib, ... }:

{
  # gpg-agent owns the SSH socket on hosts that import GPG keys.
  config = lib.mkIf (config.dotfiles.sshAgent == "gpg") {
    home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
  };
}
