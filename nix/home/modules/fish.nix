{ config, pkgs, pkgsUnstable, ... }:

let
  mkSource = relPath: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.root}/${relPath}";
in
{
  programs.fish = {
    enable = true;
    package = if pkgs ? nativeOptimized then pkgs.nativeOptimized pkgsUnstable.fish else pkgsUnstable.fish;

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
      function source_local_env --argument-names envfile
          if not test -f $envfile
              return
          end

          while read -l line
              set line (string trim -- $line)

              if test -z "$line"
                  continue
              end

              if string match -qr '^#' -- $line
                  continue
              end

              set line (string replace -r '^export[[:space:]]+' "" -- $line)

              if not string match -qr '^[A-Za-z_][A-Za-z0-9_]*=' -- $line
                  continue
              end

              set parts (string split -m 1 '=' -- $line)
              set key $parts[1]
              set raw_value $parts[2]
              eval "set -gx $key $raw_value"
          end < $envfile
      end

      source_local_env "$HOME/.config/secrets/.local.env"

      set -gx WEB_SEARCH_flac 'https://nyaa.si/?f=0&c=2_1&q='
      set -gx WEB_SEARCH_anime 'https://nyaa.si/?f=0&c=1_2&q='
      set -gx WEB_SEARCH_dict 'https://dictionary.cambridge.org/dictionary/english/'
      set -gx WEB_SEARCH_hi10 'https://hi10anime.com/?s='
      set -gx WEB_SEARCH_mal 'https://myanimelist.net/search/all?cat=all&q='

      # fix valgrind
      set -gx DEBUGINFOD_URLS 'https://debuginfod.archlinux.org'
    '';

    interactiveShellInit = ''
      set -g fish_greeting
      fish_vi_key_bindings

      bind -M insert \cf 'tmux-sessionizer'
      bind \cf 'tmux-sessionizer'
      bind -M insert \ct 'tmux'
      bind \ct 'tmux'
      bind -M insert \cr 'yy'
      bind \cr 'yy'
      bind -M insert \cg 'lbg $GUIFM .'
      bind \cg 'lbg $GUIFM .'
      bind -M insert \ce forward-char
      bind \ce forward-char

      source ~/.config/shell_aliases

      if type -q zoxide
          zoxide init fish | source
      end

      if type -q direnv
          direnv hook fish | source
      end

      if type -q lure
          lure fish init | source
      end
    '';
  };

  xdg.configFile = {
    "fish/functions".source = mkSource "fish/.config/fish/functions";
    "fish/completions".source = mkSource "fish/.config/fish/completions";
    "fish/conf.d".source = mkSource "fish/.config/fish/conf.d";
    "fish/fish_plugins".source = mkSource "fish/.config/fish/fish_plugins";
  };
}
