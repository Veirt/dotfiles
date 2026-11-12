{ lib, pkgs, ... }:

let
  sourceConfig = builtins.readFile ../../files/mango/config/config.conf;
  freyaConfig =
    lib.replaceStrings
      [
        "exec_once=foot --server"
        "bind=Super,Return,spawn,footclient"
        "bind=NONE,XF86MonBrightnessUp,spawn,brightnessctl set +5%"
        "bind=NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-"
        "bind=NONE,XF86AudioRaiseVolume,spawn,pamixer -i 5"
        "bind=NONE,XF86AudioLowerVolume,spawn,pamixer -d 5"
        "bind=NONE,XF86AudioMute,spawn,pamixer -t"
      ]
      [
        "exec_once=swaybg -i /home/veirt/pictures/wallpapers/current/main -m fill\nexec_once=vibepanel\nexec_once=env USE_LAYER_SHELL=1 vicinae-launch server\nexec_once=foot --server"
        "bind=Super,r,spawn,vicinae vicinae://toggle\nbind=Super,v,spawn,vicinae deeplink vicinae://launch/clipboard/history\nbind=Super,Return,spawn,footclient"
        "bind=NONE,XF86MonBrightnessUp,spawn,vibepanel brightness inc"
        "bind=NONE,XF86MonBrightnessDown,spawn,vibepanel brightness dec"
        "bind=NONE,XF86AudioRaiseVolume,spawn,vibepanel volume inc"
        "bind=NONE,XF86AudioLowerVolume,spawn,vibepanel volume dec"
        "bind=NONE,XF86AudioMute,spawn,vibepanel volume toggle-mute"
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
  # Share the base Mango configuration while replacing Freya's shell bindings.
  xdg.configFile."mango".source = lib.mkForce mangoConfig;
}
