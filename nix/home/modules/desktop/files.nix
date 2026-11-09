{ ... }:

{
  xdg.configFile = {
    "alacritty".source = ../../files/alacritty/config;
    "foot".source = ../../files/foot/config;
    "mango".source = ../../files/mango/config;
    "xdg-desktop-portal/mango-portals.conf".source = ../../files/mango/xdg-desktop-portal/mango-portals.conf;
  };

  home.file = {
    ".local/bin/ocr".source = ../../files/wayland/bin/ocr;
    ".local/bin/record".source = ../../files/wayland/bin/record;
    ".local/bin/screenshot" = {
      source = ../../files/wayland/bin/screenshot;
      executable = true;
    };
    ".local/bin/toggle-touchpad".source = ../../files/wayland/bin/toggle-touchpad;
  };
}
