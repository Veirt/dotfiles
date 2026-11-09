{ config, pkgs, inputs, ... }:

let
  mkSource = relPath: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.root}/${relPath}";
in
{
  programs.waybar = {
    enable = true;
    # Binary comes from gui-apps/waybar on hosts that prefer system packages;
    # this module then only manages the config.
    package = if config.dotfiles.preferSystemPackages then pkgs.emptyDirectory else pkgs.waybar;
    style = ../../../waybar/.config/waybar/style.css;
    settings = [
      {
        layer = "bottom";
        position = "top";
        height = 40;
        modules-left = [ ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
          "network"
          "clock"
          "tray"
        ];

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
          on-scroll-down = "brightnessctl set 1%-";
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
}
