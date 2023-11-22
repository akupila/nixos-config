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

  outputs = inputs@{ darwin, nixpkgs, home-manager, ... }:
    let
      user = "akupila";

      forAllSystems = fn: nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-linux"
      ]
        (system: fn nixpkgs.legacyPackages.${system});
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      # Personal laptop
      darwinConfigurations.Anttis-MBP = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs user;
        };
        modules = [
          home-manager.darwinModules.home-manager
          ./modules/default.nix
          ./modules/darwin.nix
          ./modules/personal.nix
        ];
      };

      # Work laptop
      darwinConfigurations.antti-stream = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs user;
        };
        modules = [
          home-manager.darwinModules.home-manager
          ./modules/default.nix
          ./modules/darwin.nix
          ./modules/work.nix
        ];
      };

      # # Linux laptop
      # nixosConfigurations.akupila-xps = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = {
      #     username = "akupila";
      #   };
      #   modules = [
      #     home-manager.darwinModules.home-manager
      #     ./modules/default.nix
      #   ];
      # };

    };
}
