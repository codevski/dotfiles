{
  description = "Unified configuration for macOS and NixOS machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
      # Optional: Declarative tap management
      homebrew-core = {
          url = "github:homebrew/homebrew-core";
          flake = false;
      };
      homebrew-cask = {
          url = "github:homebrew/homebrew-cask";
          flake = false;
      };
      nikitabobko-tap = {
            url = "github:nikitabobko/homebrew-tap";
            flake = false;
          };

      # homebrew-bundle = {
      #     url = "github:homebrew/homebrew-bundle";
      #     flake = false;
      #   };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    zen-browser,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    nikitabobko-tap,
    # homebrew-bundle,
    ...
  } @ inputs:
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
      specialArgs = { inherit inputs; };
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        {
          nixpkgs = commonNixpkgsConfig;
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = false;
            # User owning the Homebrew prefix
            user = "codevski";
            autoMigrate = true;
            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "nikitabobko/tap" = nikitabobko-tap;
              # "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
        };
        }
        ./modules/default.nix
        ./systems/macos/default.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-darwin"; };
          home-manager.users.codevski = import ./homes/macos.nix;
        }
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
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
          home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
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
      extraSpecialArgs = { inherit inputs; system = "x86_64-darwin"; };
      modules = [
        {
          nixpkgs = commonNixpkgsConfig;
        }
        ./homes/macos.nix
      ];
    };
  };
}
