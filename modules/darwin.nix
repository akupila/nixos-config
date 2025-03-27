{ user, pkgs, ... }:

{
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
  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, check changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
