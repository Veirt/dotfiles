{ config, lib, ... }:

let
  inherit (lib) mkIf mkMerge;

  # Package-manager aliases are host-specific; generic aliases live in
  # shared/.config/shell_aliases so bash and fish share one source of truth.
  gentoo = {
    esync = "sudo emaint sync -a";
    eup = "sudo emerge -avuDN @world";
    edepclean = "sudo emerge --depclean";
    eclean = "sudo eclean-dist -d && sudo eclean-pkg -d";
  };

  arch = {
    ua-drop-caches = "sudo paccache -rk3; paru -Sc --aur --noconfirm";
    ua-update-all =
      "export TMPFILE=\"$(mktemp)\"; sudo true; rate-mirrors --save=$TMPFILE arch --max-delay=21600 && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup && sudo mv $TMPFILE /etc/pacman.d/mirrorlist && ua-drop-caches && paru -Syyu --noconfirm";
  };
in
{
  home.shellAliases = mkMerge [
    (mkIf (config.dotfiles.initSystem == "openrc") gentoo)
    (mkIf (config.dotfiles.initSystem == "systemd") arch)
  ];
}
