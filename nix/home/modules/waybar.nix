{ config, ... }:

let
  mkSource = relPath: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.root}/${relPath}";
in
{
  programs.waybar = {
    enable = true;
    style = ../../../waybar/.config/waybar/style.css;
    settings = [
      {
        layer = "bottom";
        position = "top";
        height = 40;
        modules-left = [ "dwl/tags" ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
          "network"
          "clock"
          "tray"
        ];

        "dwl/tags" = {
          num-tags = 9;
          tag-labels = [
            "1"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
          ];
          disable-click = false;
        };

        "sway/workspaces" = {
          format = "{name}";
          disable-scroll = true;
        };

        "sway/mode" = {
          format = " {}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "  Muted";
          format-alt = "{icon}";
          format-alt-click = "click-right";
          format-icons = {
            headphones = "";
            headset = "󰋎";
            phone = "";
            default = [
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        backlight = {
          format = "{icon}  {percent}%";
          format-alt = "{icon}";
          format-alt-click = "click-right";
          format-icons = [
            "󰃚"
            "󰃛"
            "󰃜"
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "brightnessctl set +1%";
          on-scroll-down = "light set 1%-";
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-alt = "{icon}";
          format-alt-click = "click-right";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁾"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          interval = 30;
          states = {
            warning = 30;
            critical = 10;
          };
        };

        network = {
          interval = 20;
          format-alt = " ";
          format-alt-click = "click-right";
          format-wifi = "   Connected";
          format-ethernet = "󰈁  {ipaddr}/{cidr}";
          format-disconnected = "!  Disconnected";
          tooltip-format = "{ifname}: ({essid}) {ipaddr}";
          on-click = "nm-connection-editor";
        };

        clock = {
          format = "󰃭  {:%a, %d %b %H:%M}";
          format-alt = "  {:%I:%M %p}";
          format-alt-click = "click-right";
        };

        tray = {
          icon-size = 15;
          spacing = 10;
        };
      }
    ];
  };

  xdg.configFile."waybar/waybar.sh".source = mkSource "waybar/.config/waybar/waybar.sh";

  home.file = {
    ".local/share/icons/brightness.png".source = mkSource "icons/.local/share/icons/brightness.png";
    ".local/share/icons/volume.png".source = mkSource "icons/.local/share/icons/volume.png";
  };
}
