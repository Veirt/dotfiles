{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  pname = "ketch";
  version = "0.21.1";
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/1broseidon/ketch/releases/download/v${version}/ketch_${version}_linux_x86_64.tar.gz";
    hash = "sha256-1+jALsi8QbkwYLc6fO13PZ9ZIUcvT6yo66mYX8iYykg=";
  };

  sourceRoot = ".";
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 ketch "$out/bin/ketch"
    install -Dm644 LICENSE "$out/share/licenses/${pname}/LICENSE"
    install -Dm644 README.md "$out/share/doc/${pname}/README.md"
    install -Dm644 CHANGELOG.md "$out/share/doc/${pname}/CHANGELOG.md"

    runHook postInstall
  '';

  meta = {
    description = "Stateless CLI for web search, code search, library docs, and scraping";
    homepage = "https://github.com/1broseidon/ketch";
    changelog = "https://github.com/1broseidon/ketch/releases/tag/v${version}";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "ketch";
  };
}
