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
    systemPath = [ "/opt/homebrew/bin" ];

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

      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.Safari" = {
          UniversalSearchEnabled = false;
          SuppressSearchSuggestions = true;
          WebKitTabToLinksPreferenceKey = true;
          ShowFullURLInSmartSearchField = true;
          AutoOpenSafeDownloads = false;
          ShowFavoritesBar = false;
          IncludeInternalDebugMenu = true;
          IncludeDevelopMenu = true;
          WebKitDeveloperExtrasEnabledPreferenceKey = true;
          WebContinuousSpellCheckingEnabled = true;
          WebAutomaticSpellingCorrectionEnabled = false;
          AutoFillFromAddressBook = false;
          AutoFillCreditCardData = false;
          AutoFillMiscellaneousForms = false;
          WarnAboutFraudulentWebsites = true;
          WebKitJavaEnabled = false;
          WebKitJavaScriptCanOpenWindowsAutomatically = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
        };
        "com.apple.print.PrintingPrefs" = {
          # Automatically quit printer app once the print jobs complete
          "Quit When Finished" = true;
        };
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          # Check for software updates daily, not just once per week
          ScheduleFrequency = 1;
          # Download newly available updates in background
          AutomaticDownload = 1;
          # Install System data files & security updates
          CriticalUpdateInstall = 1;
        };
        "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
        # Turn on app auto-update
        "com.apple.commerce".AutoUpdate = true;
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

  # Used for backwards compatibility, check changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

}
