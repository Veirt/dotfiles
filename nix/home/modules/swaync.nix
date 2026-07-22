{ config, ... }:

{
  services.swaync = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ../../../wayland/.config/swaync/config.json);
    style = builtins.readFile ../../../wayland/.config/swaync/style.css;
  };
}
