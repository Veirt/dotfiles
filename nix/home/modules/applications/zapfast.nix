{ pkgs, ... }:

let
  zapfast = pkgs.stdenvNoCC.mkDerivation {
    pname = "zapfast";
    version = "0.21.1";

    src = pkgs.fetchurl {
      url = "https://github.com/crmne/zapfast/releases/download/v0.21.1/zapfast-v0.21.1-x86_64-unknown-linux-gnu.tar.gz";
      hash = "sha256-x+5vg3BxWKSbiXCkwjbczI4dP52IrHP/g5uI8h5dAVA=";
    };

    sourceRoot = "zapfast-v0.21.1-x86_64-unknown-linux-gnu";

    installPhase = ''
      runHook preInstall

      install -Dm755 zapfast "$out/bin/zapfast"
      install -Dm644 packaging/applications/zapfast.desktop "$out/share/applications/zapfast.desktop"
      install -Dm644 packaging/icons/zapfast.svg "$out/share/icons/hicolor/scalable/apps/zapfast.svg"

      substituteInPlace "$out/share/applications/zapfast.desktop" \
        --replace-fail 'Exec=zapfast' "Exec=$out/bin/zapfast"

      runHook postInstall
    '';

    meta = {
      description = "A fast, native WhatsApp client";
      homepage = "https://zapfast.rocks";
      license = pkgs.lib.licenses.mit;
      platforms = [ "x86_64-linux" ];
      mainProgram = "zapfast";
    };
  };
in
{
  home.packages = [ zapfast ];
}
