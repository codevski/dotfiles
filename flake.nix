{
  description = "Unified configuration for macOS and NixOS machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    # Common nixpkgs configuration for all systems
    commonNixpkgsConfig = {
      config = {
        allowUnfree = true; # Allow unfree packages globally
      };
    };
  in
  {
    darwinConfigurations."Codevski-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        {
          nixpkgs = commonNixpkgsConfig;
        }
        ./modules/default.nix
        ./systems/macos/default.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.codevski = import ./homes/macos.nix;
        }
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nixpkgs = commonNixpkgsConfig;
        }
        ./modules/default.nix
        ./systems/desktop/default.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.codevski = import ./homes/desktop.nix;
        }
      ];
    };

    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nixpkgs = commonNixpkgsConfig;
        }
        ./modules/default.nix
        ./systems/server/default.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.codevski = import ./homes/server.nix;
        }
      ];
    };

    # Optional: Define home-manager configurations for standalone use
    homeConfigurations.codevski = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-darwin;
      modules = [
        {
          nixpkgs = commonNixpkgsConfig;
        }
        ./homes/macos.nix
      ];
    };
  };
}
