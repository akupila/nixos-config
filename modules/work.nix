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
          granted
          k9s
          kubectl
          kubectx
          kubernetes-helm
          packer
          s5cmd
          sops
          terraform
          terraform-ls
          vault
        ];
      };

      programs = {
        git = {
          settings = {
            user.email = lib.mkForce "antti.kupila@iceye.com";
          };
        };
        jujutsu = {
          settings = {
            user.email = lib.mkForce "antti.kupila@iceye.com";
          };
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
