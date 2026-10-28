{ ... }: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Browsers / URL handlers
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      # Directories (used by Firefox's "Show in folder" action)
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

      # Documents
      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
      "application/epub+zip" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
      "application/postscript" = [ "org.pwmt.zathura-ps.desktop" ];

      # Text / editor placeholders
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "text/x-python" = [ "nvim.desktop" ];
      "text/x-shellscript" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];
      "application/toml" = [ "nvim.desktop" ];
      "application/xml" = [ "nvim.desktop" ];
      "text/csv" = [ "nvim.desktop" ];

      # Archives
      "application/zip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rar" = [ "org.gnome.FileRoller.desktop" ];

      # Images
      "image/png" = [ "org.gnome.gThumb.desktop" ];
      "image/jpeg" = [ "org.gnome.gThumb.desktop" ];
      "image/gif" = [ "org.gnome.gThumb.desktop" ];
      "image/webp" = [ "org.gnome.gThumb.desktop" ];
      "image/svg+xml" = [ "org.gnome.gThumb.desktop" ];

      # Video
      "video/mp4" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];

      # Audio
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];
      "audio/x-vorbis+ogg" = [ "mpv.desktop" ];
    };
  };
}
