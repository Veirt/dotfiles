{ config, lib, ... }:

let
  inherit (lib) attrNames concatMapStringsSep foldl' mapAttrs mkOption types;

  linkSets = {
    shared = {
      home = {
        ".profile" = "shared/.profile";
      };
      xdg = {
        "shell_aliases" = "shared/.config/shell_aliases";
      };
    };

    bash = {
      home = {
        ".bashrc" = "bash/.bashrc";
      };
    };

    fish = {
      xdg = {
        "fish" = "fish/.config/fish";
      };
    };

    nvim = {
      xdg = {
        "nvim" = "nvim/.config/nvim";
      };
    };

    tmux = {
      xdg = {
        "tmux" = "tmux/.config/tmux";
      };
      home = {
        ".local/bin/is_vim.c" = "tmux/.local/bin/is_vim.c";
      };
    };

    xdg = {
      xdg = {
        "user-dirs.dirs" = "xdg/.config/user-dirs.dirs";
      };
      home = {
        ".personal" = "xdg/.personal";
      };
    };

    alacritty = {
      xdg = {
        "alacritty" = "alacritty/.config/alacritty";
      };
    };

    foot = {
      xdg = {
        "foot" = "foot/.config/foot";
      };
    };

    sway = {
      xdg = {
        "mako" = "sway/.config/mako";
        "sway" = "sway/.config/sway";
        "waybar" = "sway/.config/waybar";
      };
      home = {
        ".local/share/icons" = "sway/.local/share/icons";
      };
    };

    mpv = {
      xdg = {
        "mpv" = "mpv/.config/mpv";
      };
    };

    mpd = {
      xdg = {
        "mpd" = "mpd/.config/mpd";
      };
    };

    ncmpcpp = {
      xdg = {
        "ncmpcpp" = "ncmpcpp/.config/ncmpcpp";
      };
    };
  };

  mkSource = relPath:
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.root}/${relPath}";

  selectedLinkSets = map (name: linkSets.${name}) config.dotfiles.links.packages;

  mergeSection = section:
    foldl' (acc: item: acc // (item.${section} or { })) { } selectedLinkSets;

  mkFiles = attrs:
    mapAttrs (_target: relPath: {
      source = mkSource relPath;
    }) attrs;

  validPackages = attrNames linkSets;
in
{
  options.dotfiles.links.packages = mkOption {
    type = types.listOf types.str;
    default = [ ];
  };

  config = {
    assertions = [
      {
        assertion = builtins.all (name: builtins.elem name validPackages) config.dotfiles.links.packages;
        message = "dotfiles.links.packages contains an unknown link set. Valid names: ${concatMapStringsSep ", " (name: name) validPackages}";
      }
    ];

    home.file = mkFiles (mergeSection "home");
    xdg.configFile = mkFiles (mergeSection "xdg");
  };
}
