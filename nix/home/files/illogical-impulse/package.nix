{ pkgs, pkgsUnstable }:
let
  inherit (pkgs) lib;
  qmlImports = with pkgsUnstable; [
    qt6.qt5compat
    qt6.qtpositioning
    kdePackages.kirigami
    kdePackages.syntax-highlighting
  ];
  mesa = pkgsUnstable.mesa;
  symbols = "${pkgsUnstable.material-symbols}/share/fonts/truetype/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf";
in
pkgsUnstable.writeShellApplication {
  name = "mango-ii";
  runtimeInputs = with pkgsUnstable; [ quickshell cava curl brightnessctl wireplumber networkmanager ddcutil ];
  text = ''
    export QS_CONFIG_PATH=${./ii}/shell.qml
    export QML2_IMPORT_PATH="${lib.makeSearchPath "lib/qt-6/qml" qmlImports}''${QML2_IMPORT_PATH:+:$QML2_IMPORT_PATH}"
    export II_MATERIAL_SYMBOLS=${lib.escapeShellArg symbols}
    export LIBGL_DRIVERS_PATH=${mesa}/lib/dri
    export __EGL_VENDOR_LIBRARY_FILENAMES=${mesa}/share/glvnd/egl_vendor.d/50_mesa.json
    exec quickshell "$@"
  '';
}
