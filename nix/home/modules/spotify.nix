{ pkgs, lib, ... }:

let
  spotifyAdblockSrc = pkgs.fetchFromGitHub {
    owner = "abba23";
    repo = "spotify-adblock";
    rev = "v1.0.3";
    hash = "sha256-UzpHAHpQx2MlmBNKm2turjeVmgp5zXKWm3nZbEo0mYE=";
  };

  spotifyAdblockLib = pkgs.rustPlatform.buildRustPackage {
    pname = "spotify-adblock";
    version = "1.0.3";
    src = spotifyAdblockSrc;
    cargoHash = "sha256-wPV+ZY34OMbBrjmhvwjljbwmcUiPdWNHFU3ac7aVbIQ=";

    installPhase = ''
      runHook preInstall
      install -Dm755 target/*/release/libspotifyadblock.so "$out/lib/spotify-adblock.so"
      runHook postInstall
    '';
  };

  spotifyAdblock = pkgs.symlinkJoin {
    name = "spotify-adblock";
    paths = [ pkgs.spotify ];
    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      rm -f "$out/bin/spotify"
      makeWrapper ${pkgs.spotify}/bin/spotify "$out/bin/spotify" \
        --set LD_PRELOAD ${spotifyAdblockLib}/lib/spotify-adblock.so
    '';
  };
in {
  home.packages = [ spotifyAdblock ];

  xdg.configFile."spotify-adblock/config.toml".source = spotifyAdblockSrc + "/config.toml";

  xdg.desktopEntries.spotify = {
    name = "Spotify";
    genericName = "Music Player";
    exec = "${spotifyAdblock}/bin/spotify %U";
    terminal = false;
    type = "Application";
    icon = "spotify";
    mimeType = [ "x-scheme-handler/spotify" ];
    categories = [ "Audio" "Music" "Player" "AudioVideo" ];
    settings.StartupWMClass = "spotify";
  };
}
