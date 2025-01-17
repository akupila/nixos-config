{ user, pkgs, ... }:

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
        zsh = {
          shellAliases = {
            k = "kubectl";
          };
        };
      };
    };
  };
}
