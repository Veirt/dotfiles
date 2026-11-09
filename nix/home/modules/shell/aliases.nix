{ config, ... }:

let
  # Package-manager aliases are host-specific; generic aliases live in
  # shared/.config/shell_aliases so every shell shares one source of truth.
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

  hostAliases =
    if config.dotfiles.initSystem == "openrc" then gentoo
    else if config.dotfiles.initSystem == "systemd" then arch
    else { };
in
{
  home.shellAliases = hostAliases;

  # fish consumes its own option, not home.shellAliases.
  programs.fish.shellAliases = hostAliases;
}
