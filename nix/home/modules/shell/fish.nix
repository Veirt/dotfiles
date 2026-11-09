{ config, pkgs, ... }:

let
  systemFishSupport = pkgs.runCommand "fish-home-manager-support" { } ''
    mkdir -p "$out/bin" "$out/share/fish/tools"
    ln -s "${pkgs.fish}/bin/fish_indent" "$out/bin/fish_indent"
    ln -s "${pkgs.fish}/share/fish/tools/create_manpage_completions.py" \
      "$out/share/fish/tools/create_manpage_completions.py"
  '';
in

{
  programs.fish = {
    enable = true;
    # Home Manager needs these build helpers to format Fish config and create
    # completions. Keep the Fish executable itself on the host when preferred.
    package = if config.dotfiles.preferSystemPackages then systemFishSupport else pkgs.fish;

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
