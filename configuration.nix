{ pkgs, ... }:

{
  nix = {
    settings = {
      experimental-features = "nix-command flakes"; # Enable flakes globally.
      trusted-users = [ "akupila" "root" ];
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  environment = {
    # List packages installed in system profile.
    systemPackages = with pkgs; [ git neovim ];

    # Set of paths that are added to $PATH.
    systemPath = [
      "/opt/homebrew/bin"
    ];

    # List of directories to be symlinked in /run/current-system/sw.
    pathsToLink = [
      "/share/zsh" # Required for programs.zsh.enableCompletion
    ];

    # Global environment variables.
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LANG = "en_US.UTF-8";
      GOPRIVATE = "github.com/GetStream";
    };
  };

  # Manage fonts with nix-darwin.
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

  # Let nix-darwin manage homebrew.
  # We'll use homebrew to install GUI apps as this is clunky with nix.
  homebrew = {
    enable = true;
    caskArgs = {
      require_sha = true;
      no_binaries = true;
    };
    global.brewfile = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap"; # Uninstall and delete stored settings.
      upgrade = false;
    };
    taps = [
      "homebrew/cask-versions"
    ];
    casks = [
      "1password"
      "firefox"
      "monodraw"
      "raycast"
      "rectangle"
      "slack"
      { name = "spotify"; args.require_sha = false; }
      { name = "wezterm-nightly"; args.require_sha = false; }
      "zoom"
    ];
  };


  # Fix some annoying MacOS defaults.
  system = {
    defaults = {
      dock = {
        autohide = true;

        # Disable hot corners.
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      finder = {
        AppleShowAllExtensions = true; # Show file extensions.
        AppleShowAllFiles = true; # Show hidden files.
        FXEnableExtensionChangeWarning = false; # Don't warn when changing file extension.
        FXPreferredViewStyle = "clmv"; # Default to column view.
      };
      NSGlobalDomain = {
        # Faster key repeat.
        InitialKeyRepeat = 14;
        KeyRepeat = 2;

        # Use tab to navigate all UI elements.
        AppleKeyboardUIMode = 3;

        # Misc
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 10;
      };
    };

    # This will reload the settings from the database and apply them to the
    # current session, so we do not need to logout and login again to make the
    # changes take effect.
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  users.users.akupila.home = "/Users/akupila";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Enable touch id for sudo.
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, check changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

}

