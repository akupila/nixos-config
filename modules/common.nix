{ username, ... }:

{
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ username "root" ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ./home.nix;
  };
}
