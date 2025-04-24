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
          delta
          envsubst
          fluxcd
          k9s
          kubectl
          kubernetes-helm
          sops
          terraform
          vault
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
