{ config, lib, pkgs, ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = false;
    settings = ''
      # Noctalia v5 shell for the Mango Wayland session.

      [shell]
      font_family = "Plus Jakarta Sans"
      time_format = "{:%a, %d %b  %H:%M}"
      clipboard_enabled = true
      clipboard_history_max_entries = 300
      clipboard_keep_from_closed_apps = true
      clipboard_auto_paste = "auto"
      corner_radius_scale = 1.08
      button_borders = false
      input_borders = true
      popup_borders = true
      card_borders = false
      show_close_buttons = false
      popup_shadows = true

      [shell.animation]
      enabled = true
      speed = 1.0

      [shell.panel]
      transparency_mode = "soft"
      borders = true
      border_color = "outline_variant"
      border_width = 1.0
      shadow = true
      list_item_background = true
      floating_offset = 12
      launcher_placement = "floating"
      launcher_position = "center"
      clipboard_placement = "floating"
      clipboard_position = "center"
      control_center_placement = "attached"
      wallpaper_placement = "attached"
      session_placement = "attached"

      [shell.shadow]
      direction = "down"
      alpha = 0.34

      [shell.launcher]
      layout = "full"
      width = 720
      search_position = "top"
      default_view = "recent"
      show_navigation_labels = true
      show_settings_button = false
      show_session_button = false
      compact = true
      track_usage = true
      sort_by_usage = true

      [storage]
      key_source = "secret-service"

      [wallpaper]
      enabled = true
      fill_mode = "crop"
      transition = ["fade", "wipe", "zoom"]
      transition_duration = 800
      directory = "/home/veirt/pictures/wallpapers"

      [wallpaper.default]
      path = "/home/veirt/pictures/wallpapers/current/main"

      [theme]
      mode = "dark"
      source = "wallpaper"
      wallpaper_scheme = "m3-content"

      [notification]
      enable_daemon = false
      show_app_name = true
      group_by_app = true
      layer = "overlay"
      background_opacity = 0.97

      [osd]
      enabled = false
      position = "top_center"
      follow_focused_output = true
      hide_delay_ms = 1400

      [lockscreen]
      enabled = false
      lock_before_suspend = false

      [idle.behavior.lock]
      enabled = false
      timeout = 600
      action = "lock"

      [idle.behavior.screen-off]
      enabled = true
      timeout = 600
      action = "screen_off"

      [nightlight]
      enabled = true
      temperature_day = 6500
      temperature_night = 4200

      [location]
      custom_schedule = true
      sunrise = "07:00"
      sunset = "19:00"

      [bar.main]
      enabled = false
      position = "top"
      thickness = 48
      background_opacity = 0.78
      compositor_blur = true
      radius = 20
      margin_ends = 20
      margin_edge = 8
      padding = 10
      widget_spacing = 7
      scale = 1.0
      font_scale = 1.0
      font_weight = 500
      shadow = true
      contact_shadow = false
      reserve_space = true
      capsule = true
      capsule_fill = "surface_container"
      capsule_thickness = 0.72
      capsule_radius = 16.0
      capsule_opacity = 0.78
      start = ["group:navigation"]
      center = ["clock"]
      end = ["media", "tray", "group:status", "group:actions"]

      [[bar.main.capsule_group]]
      id = "navigation"
      members = ["launcher", "wallpaper", "workspaces"]
      fill = "surface_container"
      padding = 10
      opacity = 0.88
      radius = 18
      widget_spacing = 10

      [[bar.main.capsule_group]]
      id = "status"
      members = ["network", "volume", "brightness", "battery"]
      fill = "surface_container"
      padding = 10
      opacity = 0.88
      radius = 18
      widget_spacing = 12

      [[bar.main.capsule_group]]
      id = "actions"
      members = ["notifications", "clipboard", "control-center", "session"]
      fill = "surface_container"
      padding = 10
      opacity = 0.88
      radius = 18
      widget_spacing = 10

      [widget.clock]
      format = "{:%a, %d %b} · {:%H:%M}"
      tooltip_format = "{:%A, %B %d, %Y}"

      [widget.workspaces]
      style = "regular"
      labels_only_when_occupied = true
      hide_when_empty = true
      max_label_chars = 1
      active_pill_size = 2.0
      inactive_pill_size = 1.0

      [widget.media]
      artist_first = true
      art_size = 24
      min_length = 100
      max_length = 200
      title_scroll = "on_hover"
      hide_when_no_media = true
      hide_when_idle = true
    '';
  };

  # Noctalia's Nix EGL loader needs an EGL vendor. Point only Noctalia at the
  # Nix Mesa driver so host libraries do not shadow the Nix runtime. Add
  # libheif for previews of AVIF and HEIC clipboard entries.
  home.packages = [ pkgs.plus-jakarta-sans ] ++ lib.optionals config.programs.noctalia.enable [
    (pkgs.writeShellScriptBin "noctalia-launch" ''
      export __EGL_VENDOR_LIBRARY_FILENAMES="${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
      export LD_LIBRARY_PATH="${pkgs.libheif}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      exec ${config.programs.noctalia.package}/bin/noctalia "$@"
    '')
  ];
}
