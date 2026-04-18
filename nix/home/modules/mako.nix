{ ... }:

{
  services.mako = {
    enable = true;
    extraConfig = builtins.readFile ../../../mako/.config/mako/config;
  };
}
