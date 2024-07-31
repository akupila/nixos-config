{ user, pkgs, ... }:

{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  fonts = {
    packages = [
      (pkgs.nerdfonts.override {
        fonts = [
          # Fonts to include. If we don't do this, we'll install all fonts.
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
          "JetBrainsMono" # Default for WezTerm
          "SourceCodePro"
          "Hack"
        ];
      })
    ];
  };

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
