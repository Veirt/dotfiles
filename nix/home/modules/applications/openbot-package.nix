{
  lib,
  stdenvNoCC,
  fetchurl,
  appimageTools,
  buildFHSEnv,
  mesa,
  writeShellScript,
}:
let
  pname = "openbot";
  version = "0.81.0";
  src = fetchurl {
    url = "https://github.com/nightly-labs/openbot/releases/download/v${version}/OpenBot-${version}-x86_64.AppImage";
    hash = "sha256-uOli1C/XgHpdKYnTvKwVmUd8UvcHt5/wVhEuc9X9k6M=";
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
    targetPkgs = pkgs: appimageTools.defaultFhsEnvArgs.targetPkgs pkgs ++ [ pkgs.libsecret mesa ];
    runScript = writeShellScript "openbot-run" ''
      export GBM_BACKENDS_PATH="${mesa}/lib/gbm"
      export LIBGL_DRIVERS_PATH="${mesa}/lib/dri"
      export __EGL_VENDOR_LIBRARY_FILENAMES="${mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
      exec "${contents}/openbot" "$@"
    '';
    extraInstallCommands = ''
      install -Dm444 ${contents}/openbot.desktop $out/share/applications/openbot.desktop
      substituteInPlace $out/share/applications/openbot.desktop \
        --replace-fail 'Exec=AppRun %U' 'Exec=openbot %U'
      install -Dm444 ${contents}/openbot.png $out/share/pixmaps/openbot.png
    '';
  }
)
