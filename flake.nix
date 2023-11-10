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

    darwinConfigurations = {

      # Personal laptop.
      "Anttis-MBP" = darwin.lib.darwinSystem {
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          ./modules/darwin.nix
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
  };
}
