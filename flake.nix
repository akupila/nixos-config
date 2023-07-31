{
  description = "Antti Kupila's dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ darwin, nixpkgs, home-manager, ... }: {
    formatter.aarch64-darwin =
      nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
    darwinConfigurations."Anttis-MBP" = darwin.lib.darwinSystem {
      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.akupila = import ./home.nix;
          };
        }
      ];
    };
  };
}
