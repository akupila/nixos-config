{ user, pkgs, lib, ... }:

{
  environment.variables = {
    GOPRIVATE = "github.com/iceye-ltd";
  };

  home-manager = {
    users.${user} = {
      home = {
        packages = with pkgs; [
          awscli2
          kubectl
          terraform
        ];
      };

      programs = {
        git = {
          userEmail = lib.mkForce "antti.kupila@iceye.com";
        };
        zsh = {
          shellAliases = {
            k = "kubectl";
          };
        };
      };
    };
  };
}
