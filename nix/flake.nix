{
  description = "Home Manager profiles for minerva and minimal VPS setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, sops-nix, ... }:
    let
      system = "x86_64-linux";
      mkHome = import ./lib/mkHome.nix {
        inherit home-manager nixpkgs system;
        extraModules = [ sops-nix.homeManagerModules.sops ];
        extraSpecialArgs = { inherit inputs; };
      };
    in {
      homeConfigurations = {
        minerva = mkHome {
          username = "veirt";
          homeDirectory = "/home/veirt";
          modules = [ ./home/hosts/minerva.nix ];
        };

        minimal = mkHome {
          username = "veirt";
          homeDirectory = "/home/veirt";
          modules = [ ./home/profiles/minimal.nix ];
        };
      };
    };
}
