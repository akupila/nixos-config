{
  description = "Antti Kupila's dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ darwin, nixpkgs, home-manager, ... }: {

    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

    # Personal laptop
    darwinConfigurations.Anttis-MBP = darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
        username = "akupila";
      };
      modules = [
        home-manager.darwinModules.home-manager
        ./modules/common.nix
        ./modules/darwin.nix
      ];
    };

      # Work laptop
    darwinConfigurations.antti-stream = darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
        username = "akupila";
      };
      modules = [
        home-manager.darwinModules.home-manager
        ./modules/common.nix
        ./modules/darwin.nix
      ];
    };

    # Linux laptop
    nixosConfigurations.akupila-xps = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # specialArgs = {
      #   username = "akupila";
      # };
      modules = [
        home-manager.darwinModules.home-manager
        ./modules/common.nix
      ];
    };

  };
}
