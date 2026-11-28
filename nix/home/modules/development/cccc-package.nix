{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  pname = "moznion-cccc";
  version = "1.10.1";
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/moznion/cccc/releases/download/v${version}/cccc-v${version}-x86_64-unknown-linux-musl.tar.gz";
    hash = "sha256-6jvS3iK+hN/1csH6e0vXtznw9822FYXrE4RLgPYaxhA=";
  };

  sourceRoot = ".";
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 cccc "$out/bin/cccc"
    install -Dm644 LICENSE "$out/share/licenses/${pname}/LICENSE"
    install -Dm644 README.md "$out/share/doc/${pname}/README.md"

    runHook postInstall
  '';

  meta = {
    description = "Cognitive and cyclomatic complexity analyzer";
    homepage = "https://github.com/moznion/cccc";
    changelog = "https://github.com/moznion/cccc/releases/tag/v${version}";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "cccc";
  };
}
