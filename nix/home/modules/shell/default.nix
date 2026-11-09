{ ... }:

{
  imports = [ ./fish.nix ];

  home.file = {
    ".profile".source = ../../files/shell/profile;
    ".bashrc".source = ../../files/bash/bashrc;
  };

  xdg.configFile."shell_aliases".source = ../../files/shell/shell_aliases;
}
