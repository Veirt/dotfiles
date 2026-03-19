{ pkgs, lib, ... }:

let
  themeName = "Orchis-Grey-Dark-Compact";
  iconThemeName = "Tela-grey-dark";
in
{
  home.sessionVariables = {
    GTK_THEME = themeName;
    GTK2_RC_FILES = lib.mkForce " $XDG_CONFIG_HOME/gtk-2.0/gtkrc";
  };

  gtk = {
    enable = true;
    theme = {
      name = themeName;
      package = pkgs.orchis-theme;
    };
    iconTheme = {
      name = iconThemeName;
      package = pkgs.tela-icon-theme;
    };

    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = 1
    '';

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk3.bookmarks = [
      "file:///home/veirt/thesis thesis"
      "file:///home/veirt/documents documents"
      "file:///home/veirt/downloads downloads"
      "file:///home/veirt/pictures pictures"
      "file:///mnt/storage storage"
      "file:///mnt/storage/public public"
    ];
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = themeName;
    icon-theme = iconThemeName;
  };
}
