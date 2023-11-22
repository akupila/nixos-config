{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    gnumake
    lua-language-server
    nil
    nixpkgs-fmt
    nodejs_20
  ];
}
