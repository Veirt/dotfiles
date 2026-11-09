{
  description = "Home Manager profiles for minerva, freya, and minimal VPS setup";

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    vibepanel.url = "github:prankstr/vibepanel";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, sops-nix, noctalia, ... }:
    let
      system = "x86_64-linux";
      mkHome = import ./lib/mkHome.nix {
        inherit home-manager nixpkgs system;
        extraModules = [
          sops-nix.homeManagerModules.sops
          noctalia.homeModules.default
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    in {
      homeConfigurations = {
        minerva = mkHome {
          username = "veirt";
          homeDirectory = "/home/veirt";
          modules = [ ./home/hosts/minerva.nix ];
        };

        freya = mkHome {
          username = "veirt";
          homeDirectory = "/home/veirt";
          modules = [ ./home/hosts/freya.nix ];
        };

        minimal = mkHome {
          username = "veirt";
          homeDirectory = "/home/veirt";
          modules = [ ./home/profiles/minimal.nix ];
        };
      };
    };
}
