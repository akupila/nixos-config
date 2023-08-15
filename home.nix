{ pkgs, ... }:

{
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      gnupg
      go
      gopls
      jq
      jump
      lua-language-server
      neovim
      nil
      nixpkgs-fmt
      nodejs_18 # LTS
      ripgrep
    ];
  };

  xdg.configFile = {
    nvim = {
      source = ./dotfiles/nvim;
      recursive = true;
    };
    wezterm = {
      source = ./dotfiles/wezterm;
      recursive = true;
    };
    rectangle = {
      source = ./dotfiles/rectangle;
      recursive = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    aliases = { checkotu = "checkout"; };
    ignores = [ ".DS_Store" ".envrc" ".direnv" ".local*" ];
    signing.key = null;
    signing.signByDefault = true;
    userEmail = "akupila@gmail.com";
    userName = "Antti Kupila";
    extraConfig = {
      color.ui = "auto";
      commit.gpgsign = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autosquash = true;
      rebase.autostash = true;
      format.pretty = "minimal";
      pretty = {
        minimal = "%C(auto)%h %d %C(bold)%s%C(reset) %C(dim)(%cr)%C(reset)";
      };
    };
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        src = zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./dotfiles/zsh;
        file = "p10k.zsh";
      }
    ];
    shellAliases = {
      "." = "pwd";
      ".." = "cd ..";
      gd = "git diff";
      gds = "git diff --staged";
      gl = "git log";
      gp = "git log --stat --max-count=1 --format=medium";
      gs = "git status";
      l = "ls -alh";
      nixrebuild = "darwin-rebuild switch --flake ~/nixos-config/.#";
      nixupdate = "pushd ~/nixos-config; nix flake update; nixrebuild; popd";
    };
    history = {
      ignorePatterns = [ "exit" "rm *" ];
      ignoreSpace = true;
    };
    initExtraBeforeCompInit = ''
      P10K_INSTANT_PROMPT="$HOME/.cache/p10k-instant-prompt-$USER.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';
    initExtra = ''
      # jump shell
      eval $(${pkgs.jump}/bin/jump shell zsh)

      # Do not exit on ctrl-d
      setopt ignore_eof
    '';
  };
}
