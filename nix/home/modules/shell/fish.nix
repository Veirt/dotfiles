{ ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      google = "web-search google";
      github = "web-search github";
      anime = "web-search anime";
      hi10 = "web-search hi10";
      mal = "web-search mal";
      yt = "web-search youtube";
      opt = "web-search nixoptions";
      pkg = "web-search nixpkgs";
    };

    shellInit = ''
      source ${../../files/fish/shell-init.fish}
    '';

    interactiveShellInit = ''
      source ${../../files/fish/interactive-init.fish}
    '';
  };

  xdg.configFile = {
    "fish/functions".source = ../../files/fish/config/functions;
    "fish/completions".source = ../../files/fish/config/completions;
    "fish/conf.d".source = ../../files/fish/config/conf.d;
    "fish/fish_plugins".source = ../../files/fish/config/fish_plugins;
  };
}
