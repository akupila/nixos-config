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
          gnutls
          k9s
          kubectl
          kubectx
          kubernetes-helm
          packer
          sops
          terraform
          terraform-ls
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
