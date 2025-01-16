{ user, pkgs, ... }:

{
  environment.variables = {
    GOPRIVATE = "github.com/iceye-ltd";
  };

  home-manager = {
    users.${user} = {
      home = {
        packages = with pkgs; [
          kubectl
        ];
      };
    };
  };
}
