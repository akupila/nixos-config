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
      # NVIM v0.13.0-dev-1511+g5209695703 (2026-09-03)
      url = "github:nix-community/neovim-nightly-overlay/64881b6f6207e36da03010d011d438829230e29a";
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

      # Work laptops
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

      darwinConfigurations.akupila-M-CD6FWKT6W0 = darwin.lib.darwinSystem {
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
