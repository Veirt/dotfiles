{ home-manager, nixpkgs, system, extraModules ? [ ], extraSpecialArgs ? { } }:
{ username, homeDirectory, modules }:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = extraSpecialArgs // {
    inherit system username homeDirectory;
  };
  modules =
    extraModules
    ++ [
      ({ ... }: {
        home.username = username;
        home.homeDirectory = homeDirectory;
      })
    ]
    ++ modules;
}
