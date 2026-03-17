{ pkgs, pkgsUnstable, ... }:

let
  ndkVersion = "28.2.13676358";

  androidPackages = pkgsUnstable.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "latest";
    platformToolsVersion = "latest";
    buildToolsVersions = [ "35.0.0" "34.0.0" ];
    platformVersions = [ "35" "34" ];
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "arm64-v8a" ];
    includeEmulator = "if-supported";
    includeNDK = true;
    ndkVersions = [ ndkVersion ];
    includeSources = true;
    extraLicenses = [ "android-sdk-preview-license" ];
  };

  androidSdk = androidPackages.androidsdk;
  androidSdkRoot = "${androidSdk}/libexec/android-sdk";
in {
  home.packages = [
    pkgsUnstable.flutter
    pkgs.jdk17
    pkgs.pkg-config
    androidSdk
  ];

  home.sessionPath = [
    "${androidSdkRoot}/cmdline-tools/latest/bin"
    "${androidSdkRoot}/platform-tools"
    "${androidSdkRoot}/emulator"
  ];

  home.sessionVariables = {
    ANDROID_HOME = androidSdkRoot;
    ANDROID_SDK_ROOT = androidSdkRoot;
    ANDROID_NDK_HOME = "${androidSdkRoot}/ndk/${ndkVersion}";
  };
}
