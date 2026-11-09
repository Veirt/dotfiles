{ lib, pkgs, ... }:

let
  source = pkgs.fetchFromGitHub {
    owner = "abba23";
    repo = "spotify-adblock";
    rev = "0f1873638f5dd0ccd62741a518bbe4ccc7670cf9";
    hash = "sha256-zQiEByj/OjOMgy3JSjk3RyPAX//yYt/2s84f5Ok1uTI=";
  };

  adblock = pkgs.rustPlatform.buildRustPackage {
    pname = "spotify-adblock";
    version = "unstable-2026-11-09";
    src = source;
    cargoLock.lockFile = "${source}/Cargo.lock";
    doCheck = false;
    postInstall = ''
      install -Dm644 ${source}/config.toml $out/share/spotify-adblock/config.toml
    '';
  };

  spotify = pkgs.spotify;
  spotifyAdblocked = pkgs.writeShellScriptBin "spotify-adblocked" ''
    export LD_PRELOAD="${adblock}/lib/libspotifyadblock.so''${LD_PRELOAD:+:$LD_PRELOAD}"
    exec ${spotify}/bin/spotify "$@"
  '';
in
{
  home.packages = [ spotify spotifyAdblocked ];

  xdg.configFile."spotify-adblock/config.toml".source = "${adblock}/share/spotify-adblock/config.toml";

  xdg.desktopEntries.spotify-adblocked = {
    name = "Spotify (ad-blocked)";
    genericName = "Music Player";
    exec = "${spotifyAdblocked}/bin/spotify-adblocked %U";
    icon = "spotify-client";
    terminal = false;
    categories = [ "Audio" "Music" "Player" "AudioVideo" ];
    mimeType = [ "x-scheme-handler/spotify" ];
  };
}
