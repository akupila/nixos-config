{ user, ... }:

{
  nix.settings = {
    trusted-users = [
      "root"
      user
    ];
    experimental-features = "nix-command flakes";
    substituters = [
      "https://akupila-nixos-config.cachix.org"
    ];
    trusted-public-keys = [
      "akupila-nixos-config.cachix.org-1:pjuJHO7gzNWy1dlXlr86qWi0oK+zSVy/dTYxh8V4VxM="
    ];
  };
  nixpkgs.config.allowUnfree = true;

  environment = {
    # List of directories to be symlinked in /run/current-system/sw.
    pathsToLink = [
      "/share/zsh" # Required for programs.zsh.enableCompletion
    ];

    # Global environment variables.
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LANG = "en_US.UTF-8";
    };
  };

  # Create /etc/zshrc that loads the nix environment.
  programs.zsh.enable = true;

  # Set up user-specific config.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = import ./home.nix;
  };
}
