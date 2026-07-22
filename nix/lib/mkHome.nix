{
  home-manager,
  nixpkgs,
  system,
  extraModules ? [ ],
  extraSpecialArgs ? { },
}:
{
  username,
  homeDirectory,
  modules,
}:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        terraform = extraSpecialArgs.inputs.nixpkgs-terraform.packages.${system}."terraform-1.14.6";
      })
    ];
  };

  pkgsUnstable = import extraSpecialArgs.inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = extraSpecialArgs // {
    inherit
      system
      username
      homeDirectory
      pkgsUnstable
      ;
  };
  modules =
    extraModules
    ++ [
      (
        { ... }:
        {
          nixpkgs.config.allowUnfree = true;
          home.username = username;
          home.homeDirectory = homeDirectory;
        }
      )
    ]
    ++ modules;
}
