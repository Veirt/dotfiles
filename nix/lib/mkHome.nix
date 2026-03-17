{ home-manager, nixpkgs, system, extraModules ? [ ], extraSpecialArgs ? { } }:
{ username, homeDirectory, modules }:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  pkgsUnstable = import extraSpecialArgs.inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = extraSpecialArgs // {
    inherit system username homeDirectory pkgsUnstable;
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
