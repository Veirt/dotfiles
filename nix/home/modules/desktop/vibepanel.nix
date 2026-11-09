{ inputs, pkgs, ... }:

let
  vibepanel = inputs.vibepanel.packages.${pkgs.system}.default.overrideAttrs (_: {
    doCheck = false;
  });
in
{
  home.packages = [ vibepanel ];

  xdg.configFile."vibepanel/config.toml".text = ''
    [bar]
    position = "top"
    auto_hide = "never"
    size = 42
    screen_margin = 8
    inset = 10
    spacing = 8
    border_radius = 48
    background_opacity = 0.0

    [widgets]
    left = [ { group = ["workspaces" }, "window_title" ]
    center = ["media"]
    right = ["tray", { group = ["cpu", "memory"] }, "quick_settings", "battery", "clock", "notifications"]
    border_radius = 42
    background_opacity = 0.88
    popover_background_opacity = 0.97

    [widgets.workspaces]
    label_type = "index"
    show_windows = true
    max_windows = 4

    [widgets.clock]
    format = "%a, %d %b  %H:%M"

    [theme]
    mode = "auto"
    scheme = "dark"
    wallpaper = "/home/veirt/pictures/wallpapers/current/main"
    accent = "#b9cbd0"
    blur = true
    shadows = true
    outline = true
    outline_width = 1
    outline_color = "subtle"
    outline_opacity = 0.18

    [theme.typography]
    font_family = "Plus Jakarta Sans"
    font_scale = 0.44

    [theme.icons]
    theme = "material"
    weight = 450

    [osd]
    enabled = true
    position = "top"
    show_value = true

    [advanced]
    compositor = "mango"
  '';
}
