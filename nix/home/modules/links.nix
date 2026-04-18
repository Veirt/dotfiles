{ config, lib, ... }:

let
  inherit (lib)
    attrNames
    concatMapStringsSep
    foldl'
    mapAttrs
    mkOption
    types
    ;

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
        ".local/bin/tmux-sessionizer" = "tmux/.local/bin/tmux-sessionizer";
        ".local/bin/tmux-vim-select-pane" = "tmux/.local/bin/tmux-vim-select-pane";
      };
    };

    wayland = {
      home = {
        ".local/bin/backlightctl" = "wayland/.local/bin/backlightctl";
        ".local/bin/backlight-toggle" = "wayland/.local/bin/backlight-toggle";
        ".local/bin/notify-send.sh" = "wayland/.local/bin/notify-send.sh";
        ".local/bin/ocr" = "wayland/.local/bin/ocr";
        ".local/bin/pape" = "wayland/.local/bin/pape";
        ".local/bin/record" = "wayland/.local/bin/record";
        ".local/bin/screenshot" = "wayland/.local/bin/screenshot";
        ".local/bin/volumectl" = "wayland/.local/bin/volumectl";
        ".local/bin/wmenu-desktop" = "wayland/.local/bin/wmenu-desktop";
      };
    };

    dev = {
      home = {
        ".local/bin/cheat" = "dev/.local/bin/cheat";
        ".local/bin/j" = "dev/.local/bin/j";
      };
    };

    media = {
      home = {
        ".local/bin/batch-convert-jxl" = "media/.local/bin/batch-convert-jxl";
      };
    };

    system = {
      home = {
        ".local/bin/bt" = "system/.local/bin/bt";
        ".local/bin/campus" = "system/.local/bin/campus";
        ".local/bin/home" = "system/.local/bin/home";
        ".local/bin/out" = "system/.local/bin/out";
        ".local/bin/update" = "system/.local/bin/update";
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

  };

  mkSource = relPath: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.root}/${relPath}";

  selectedLinkSets = map (name: linkSets.${name}) config.dotfiles.links.packages;

  mergeSection = section: foldl' (acc: item: acc // (item.${section} or { })) { } selectedLinkSets;

  mkFiles =
    attrs:
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
        message = "dotfiles.links.packages contains an unknown link set. Valid names: ${
          concatMapStringsSep ", " (name: name) validPackages
        }";
      }
    ];

    home.file = mkFiles (mergeSection "home");
    xdg.configFile = mkFiles (mergeSection "xdg");
  };
}
