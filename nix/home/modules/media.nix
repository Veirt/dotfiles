{ config, pkgsUnstable, ... }:

let
  mkSource = relPath: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.root}/${relPath}";
in
{
  services.mpd = {
    enable = true;
    musicDirectory = "/mnt/storage/music";

    extraConfig = ''
      log_file "syslog"
      auto_update "yes"
      restore_paused "yes"

      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };

  programs.mpv = {
    enable = true;
    package = pkgsUnstable.mpv;

    config = {
      save-position-on-quit = true;
      osd-fractions = true;

      vo = "gpu-next";
      hwdec = "vaapi";
      gpu-api = "vulkan";
      profile = "gpu-hq";

      scale = "catmull_rom";
      cscale = "catmull_rom";
      dscale = "catmull_rom";
      video-sync = "display-resample";

      cache = true;
      cache-secs = 300;
      sub-auto = "fuzzy";
      slang = "jp,jpn,ja,en,eng";
      alang = "jp,jpn,ja,en,eng";

      screenshot-format = "webp";
      screenshot-webp-lossless = true;
      screenshot-high-bit-depth = true;
      screenshot-sw = false;
      screenshot-directory = "~/pictures/screenshots/mpv/";
      screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";
    };
  };

  programs.ncmpcpp = {
    enable = true;

    settings = {
      lyrics_directory = "~/.local/share/lyrics";
      lines_scrolled = 1;
      message_delay_time = 3;
      playlist_display_mode = ''"columns"'';
      browser_display_mode = ''"columns"'';
      search_engine_display_mode = ''"columns"'';
      playlist_editor_display_mode = ''"columns"'';
      autocenter_mode = true;
      centered_cursor = true;
      user_interface = ''"classic"'';
      follow_now_playing_lyrics = true;
      locked_screen_width_part = ''"60"'';
      display_bitrate = false;
      external_editor = ''"nvim"'';
      main_window_color = "default";
      progressbar_elapsed_color = 5;
      progressbar_color = ''"black"'';
      progressbar_look = ''"━━─"'';
      mouse_support = true;
      header_visibility = false;
      statusbar_visibility = true;
      titles_visibility = false;
      enable_window_title = true;
      current_item_prefix = ''"$r"'';
      song_columns_list_format = ''"(6)[]{} (25)[white]{a} (34)[white]{t|f} (5f)[white]{l} (1)[]{}"'';
      color1 = ''"white"'';
      color2 = ''"white"'';
      song_status_format = ''"♫ %a - %t"'';
      song_window_title_format = ''"♫ %a - %t"'';
      browser_sort_mode = "name";
      browser_sort_format = ''"{%a - }{%t}|{%f} {(%l)}"'';
      execute_on_song_change = ''"~/.config/ncmpcpp/scripts/notify-cover-art"'';
    };

    bindings = [
      {
        key = "+";
        command = "show_clock";
      }
      {
        key = "=";
        command = "volume_up";
      }
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "ctrl-u";
        command = "page_up";
      }
      {
        key = "ctrl-d";
        command = "page_down";
      }
      {
        key = "h";
        command = "previous_column";
      }
      {
        key = "l";
        command = "next_column";
      }
      {
        key = ".";
        command = "show_lyrics";
      }
      {
        key = "n";
        command = "next_found_item";
      }
      {
        key = "N";
        command = "previous_found_item";
      }
      {
        key = "J";
        command = "move_sort_order_down";
      }
      {
        key = "K";
        command = "move_sort_order_up";
      }
    ];
  };

  xdg.configFile = {
    "mpv/scripts".source = mkSource "mpv/.config/mpv/scripts";
    "ncmpcpp/scripts".source = mkSource "ncmpcpp/.config/ncmpcpp/scripts";
    "discord-rpc/config.toml".source = mkSource "mpd/.config/discord-rpc/config.toml";
  };

  systemd.user.services.mpd-discord-rpc = {
    Unit = {
      Description = "Discord Rich Presence for MPD";
      Requires = [ "mpd.service" ];
      After = [ "mpd.service" ];
    };

    Service = {
      ExecStart = "${config.home.homeDirectory}/.cargo/bin/mpd-discord-rpc";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
