{
  lib,
  stdenvNoCC,
  fetchurl,
  appimageTools,
  buildFHSEnv,
}:
let
  pname = "openbot";
  version = "0.74.0";
  src = fetchurl {
    url = "https://github.com/nightly-labs/openbot/releases/download/v${version}/OpenBot-${version}-x86_64.AppImage";
    hash = "sha256-A526eP2PniKV/G7R7cglxraopowewCSA6+HKvhOQi2k=";
  };
  meta = {
    description = "Local-first multi-agent desktop workspace";
    homepage = "https://github.com/nightly-labs/openbot";
    changelog = "https://github.com/nightly-labs/openbot/releases/tag/v${version}";
    license = {
      shortName = "polyform-nc-10";
      fullName = "PolyForm Noncommercial License 1.0.0";
      spdxId = "PolyForm-Noncommercial-1.0.0";
      url = "https://polyformproject.org/licenses/noncommercial/1.0.0/";
      free = false;
      redistributable = false;
    };
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "openbot";
  };
  contents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      rm -rf $out/resources/remote-desktop-runtime
    '';
  };
in
buildFHSEnv (
  appimageTools.defaultFhsEnvArgs
  // {
    inherit pname version meta;
    targetPkgs = pkgs: appimageTools.defaultFhsEnvArgs.targetPkgs pkgs ++ [ pkgs.libsecret ];
    runScript = "${contents}/openbot";
    extraInstallCommands = ''
      install -Dm444 ${contents}/openbot.desktop $out/share/applications/openbot.desktop
      substituteInPlace $out/share/applications/openbot.desktop \
        --replace-fail 'Exec=AppRun %U' 'Exec=openbot %U'
      install -Dm444 ${contents}/openbot.png $out/share/pixmaps/openbot.png
    '';
  }
)
