{ user, pkgs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
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
