{ pkgs, pkgsUnstable, ... }:

{
  imports = [
    ../profiles/freya.nix
    ../modules/firefox-fastfox.nix
    ../modules/firefox-psd.nix
    ../modules/spotify.nix
    ../modules/zapfast.nix
  ];

  dotfiles.root = "/home/veirt/.dotfiles";
  dotfiles.preferSystemPackages = true;
  dotfiles.initSystem = "openrc";
  # The backup's gpg-private.asc is empty, so gpg-agent has no SSH key here.
  dotfiles.sshAgent = "ssh";
  dotfiles.nativeBuilds.enable = true;
  home.packages = [
    pkgsUnstable.yazi
    pkgsUnstable.syncthing
    pkgsUnstable.gotop
    pkgsUnstable.typst
    (pkgsUnstable.texliveSmall.withPackages (tex: with tex; [
      scheme-medium collection-langchinese collection-latexextra
      collection-fontsextra collection-fontsrecommended xetex
    ]))
    pkgsUnstable.pandoc
    (pkgsUnstable.tesseract.override { enableLanguages = [ "eng" "ind" "jpn" "osd" ]; })
    pkgsUnstable.obs-studio
    pkgsUnstable.pavucontrol
    pkgsUnstable.nmap
    pkgsUnstable.tcpdump
    pkgsUnstable.iperf3
    pkgsUnstable.rclone
    pkgsUnstable.ripgrep
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
  ];

  home.file.".local/share/freya/syncthing.openrc" = {
    executable = true;
    text = ''
      #!/sbin/openrc-run
      description="Syncthing for veirt"
      command="/home/veirt/.nix-profile/bin/syncthing"
      command_args="serve --no-browser --no-restart --home=/home/veirt/.local/state/syncthing"
      command_user="veirt:veirt"
      supervisor="supervise-daemon"
      export HOME="/home/veirt"

      depend() {
        need localmount
        after net
      }
    '';
  };

  home.file.".bash_profile".text = ''. "$HOME/.profile"'';

  xdg.configFile."freya/login.sh".text = ''
    # Start the desktop on tty1, without affecting SSH or other terminals.
    if [ "$(tty)" = /dev/tty1 ] && [ -z "''${WAYLAND_DISPLAY:-}" ] && [ -z "''${DISPLAY:-}" ]; then
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=mango
      mkdir -p "$HOME/.local/state/mango"
      ulimit -c unlimited
      exec dbus-run-session -- mango -d >>"$HOME/.local/state/mango/session.log" 2>&1
    fi
  '';

  home.sessionVariables = {
    # The eDP panel is wired to the Intel UHD 630; VA-API must use iHD.
    LIBVA_DRIVER_NAME = "iHD";
    WLR_DRM_NO_MODIFIERS = "1";
    DEBUGINFOD_URLS = "https://debuginfod.gentoo.org";
  };
}
