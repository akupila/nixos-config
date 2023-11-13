{ username,  pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  services.nix-daemon.enable = true;

  fonts = {
    fontDir.enable = true; # Note: This will remove any manually installed fonts.
    fonts = [
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

  users.users.${username}.home = "/Users/${username}";

  # Enable touch id for sudo.
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, check changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
