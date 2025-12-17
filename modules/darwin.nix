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

  nixpkgs.config.allowUnfree = true;

  users.users.${user}.home = "/Users/${user}";

  # Enable touch id for sudo.
  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = user;

  system.defaults.NSGlobalDomain = {
    InitialKeyRepeat = 10; # Normal minimum is 15 (225ms)
    KeyRepeat = 1; # Normal minimum is 2 (30ms)
  };

  # Used for backwards compatibility, check changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
