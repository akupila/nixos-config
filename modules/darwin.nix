{ user, pkgs, ... }:

{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  fonts.packages = [
    pkgs.nerd-fonts.sauce-code-pro
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.jetbrains-mono # Default for WezTerm
  ];

  environment = {
    systemPath = [ "/opt/homebrew/bin" ];
  };

  users.users.${user}.home = "/Users/${user}";

  # Enable touch id for sudo.
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, check changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
