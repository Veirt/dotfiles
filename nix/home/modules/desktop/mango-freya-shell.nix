{ lib, pkgs, ... }:

let
  sourceConfig = builtins.readFile ../../files/mango/config/config.conf;
  freyaConfig = lib.replaceStrings
    [
      "exec_once=noctalia-launch"
      "bind=Super,r,spawn,noctalia msg panel-toggle launcher"
      "bind=Super,v,spawn,noctalia msg panel-toggle clipboard"
      "bind=Super,s,spawn,noctalia msg panel-toggle control-center"
      "bind=SUPER+SHIFT,s,spawn,noctalia msg screenshot-region"
      "# Noctalia owns shell surfaces and their OSDs."
      "bind=NONE,XF86MonBrightnessUp,spawn,noctalia msg brightness-up"
      "bind=NONE,XF86MonBrightnessDown,spawn,noctalia msg brightness-down"
      "bind=NONE,XF86AudioRaiseVolume,spawn,noctalia msg volume-up"
      "bind=NONE,XF86AudioLowerVolume,spawn,noctalia msg volume-down"
      "bind=NONE,XF86AudioMute,spawn,noctalia msg volume-mute"
      "bind=NONE,XF86AudioMicMute,spawn,noctalia msg mic-mute"
    ]
    [
      "exec_once=swaybg -i /home/veirt/pictures/wallpapers/current/main -m fill\nexec_once=vibepanel\nexec_once=env USE_LAYER_SHELL=1 vicinae-launch server"
      "bind=Super,r,spawn,vicinae vicinae://toggle"
      "bind=Super,v,spawn,vicinae deeplink vicinae://launch/clipboard/history"
      "bind=Super,s,spawn,vibepanel popover toggle quick-settings"
      "bind=SUPER+SHIFT,s,spawn,screenshot"
      "# VibePanel owns quick settings and system OSDs."
      "bind=NONE,XF86MonBrightnessUp,spawn,vibepanel brightness inc"
      "bind=NONE,XF86MonBrightnessDown,spawn,vibepanel brightness dec"
      "bind=NONE,XF86AudioRaiseVolume,spawn,vibepanel volume inc"
      "bind=NONE,XF86AudioLowerVolume,spawn,vibepanel volume dec"
      "bind=NONE,XF86AudioMute,spawn,vibepanel volume toggle-mute"
      "bind=NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ]
    sourceConfig;

  mangoConfig = pkgs.runCommand "mango-config-freya" { } ''
    mkdir -p "$out"
    cp -r ${../../files/mango/config}/. "$out/"
    chmod u+w "$out/config.conf"
    cp ${pkgs.writeText "config.conf" freyaConfig} "$out/config.conf"
  '';
in
{
  # Noctalia remains available for Minerva, but is absent from Freya's profile.
  programs.noctalia.enable = lib.mkForce false;

  # Share the base Mango configuration while replacing Freya's shell bindings.
  xdg.configFile."mango".source = lib.mkForce mangoConfig;
}
