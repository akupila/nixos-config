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
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ darwin, nixpkgs, home-manager, neovim-nightly-overlay, ... }:
    let
      user = "akupila";
      overlays = [ neovim-nightly-overlay.overlays.default ];
    in
    {
      # Personal laptop
      darwinConfigurations.Anttis-MBP = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs user;
        };
        modules = [
          { nixpkgs.overlays = overlays; }
          home-manager.darwinModules.home-manager
          ./modules/default.nix
          ./modules/darwin.nix
          ./modules/personal.nix
        ];
      };

      # Work laptop
      darwinConfigurations.akupila-M-CQ3LG7V9X3 = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs user;
        };
        modules = [
          { nixpkgs.overlays = overlays; }
          home-manager.darwinModules.home-manager
          ./modules/default.nix
          ./modules/darwin.nix
          ./modules/work.nix
        ];
      };

    };
}
