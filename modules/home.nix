{ inputs, pkgs, ... }:

let
  dotfiles = path: {
    source = ./../dotfiles/${path};
    recursive = true;
  };
in
{
  home = {
    # Binaries installed for current user.
    packages = with pkgs; [
      go_1_21
      gnupg
      jump
      neovim
      ripgrep
      yubikey-manager
    ];

    stateVersion = "23.11";
  };

  xdg.configFile = {
    nvim = dotfiles "nvim";
    wezterm = dotfiles "wezterm";
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      aliases = {
        checkotu = "checkout";
        recent = "for-each-ref --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))' refs/heads";
      };
      ignores = [ ".DS_Store" ".envrc" ".direnv" ".local*" "shell.nix" ];
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
        url."git@github.com:".insteadOf = "https://github.com";
      };
    };

    zsh = {
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
          src = ./../dotfiles/zsh;
          file = "p10k.zsh";
        }
        {
          name = "gocover";
          src = ./../dotfiles/zsh;
          file = "gocover.zsh";
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

        # Keys
        bindkey '^[[3~'   delete-char   # Delete
        bindkey '^[[C'    forward-char  # Right
        bindkey '^[[D'    backward-char # Left
        bindkey '^[[1;5D' backward-word # Ctrl-Left
        bindkey '^[[1;5C' forward-word  # Ctrl-Right
        bindkey '^H' backward-kill-word # Ctrl-H deletes word
        bindkey '^[[Z' undo             # Shift-Tab

        export PATH=$PATH:~/go/bin
      '';
    };
  };
}
