{ pkgs, pkgsUnstable, ... }:

let
  psd = "${pkgsUnstable.profile-sync-daemon}/bin/profile-sync-daemon";

  psdRunner = pkgs.writeShellScript "psd-openrc-user-runner" ''
    sleep_pid=

    cleanup() {
      trap - EXIT HUP INT TERM
      if [ -n "$sleep_pid" ]; then
        kill "$sleep_pid" 2>/dev/null || true
        wait "$sleep_pid" 2>/dev/null || true
      fi
      "${psd}" unsync
    }

    trap cleanup EXIT
    trap 'exit 0' HUP INT TERM

    # OpenRC starts this runner only after the service has synced the profile.
    # Resync periodically, then write back and unmount on service stop.
    while :; do
      ${pkgs.coreutils}/bin/sleep 3600 &
      sleep_pid=$!
      wait "$sleep_pid" || true
      sleep_pid=
      "${psd}" resync || printf '%s\n' 'PSD hourly resync failed; will retry in one hour.' >&2
    done
  '';

  psdService = pkgs.writeTextFile {
    name = "psd";
    executable = true;
    text = ''
      #!/sbin/openrc-run
      description="Profile-sync-daemon for Firefox"
      command="${psdRunner}"
      command_background=yes
      pidfile="''${XDG_RUNTIME_DIR}/psd-openrc.pid"

      start_pre() {
        ${psd} sync
      }

      stop_post() {
        ${psd} unsync
      }
    '';
  };
in
{
  home.packages = [ pkgsUnstable.profile-sync-daemon ];

  xdg.configFile."psd/psd.conf".text = ''
    # Manage Firefox profiles only. PSD v7 uses fuse-overlayfs by default.
    BROWSERS=(firefox)
    USE_BACKUPS="yes"
    BACKUP_LIMIT=5
  '';

  # OpenRC has no upstream PSD service. Keep a small user service and hourly
  # resync loop in the Nix-managed user runlevel for this OpenRC host.
  home.file.".config/rc/init.d/psd".source = psdService;
  home.file.".config/rc/runlevels/default/psd".source = psdService;
}
