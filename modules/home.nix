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
      difftastic
      gnupg
      go_1_22
      jq
      jump
      neovim
      nodejs
      ripgrep
      yubikey-manager
    ];

    stateVersion = "23.11";
  };

  xdg.configFile = {
    nvim = dotfiles "nvim";
    wezterm = dotfiles "wezterm";
    atuin = dotfiles "atuin";
  };

  programs = {
    atuin = {
      enable = true;
      flags = [
        "--disable-up-arrow"
      ];
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
    };

    git = {
      enable = true;
      aliases = {
        recent = "for-each-ref --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))' refs/heads";
        fixup = "!f() { git commit --fixup $1; GIT_SEQUENCE_EDITOR=true git rebase -i --autostash --autosquash $1^; }; f";
        wip = "commit -m 'wip [skip ci]'";
      };
      ignores = [ ".DS_Store" ".envrc" ".direnv" ".local*" "shell.nix" ];
      signing.key = null;
      userEmail = "akupila@gmail.com";
      userName = "Antti Kupila";
      extraConfig = {
        color.ui = "auto";
        commit = {
          gpgSign = true;
          verbose = true;
        };
        diff = {
          external = "difft";
        };
        format.pretty = "minimal";
        help.autocorrect = 1;
        init.defaultBranch = "main";
        merge = {
          tool = "opendiff";
          conflictstyle = "zdiff3";
          keepbackup = false;
        };
        pretty = {
          minimal = "%C(auto)%h %d %C(bold)%s%C(reset) %C(dim)(%cr)%C(reset)";
        };
        pull = {
          rebase = true;
        };
        push = {
          default = "current";
        };
        rebase = {
          autosquash = true;
          autostash = true;
        };
        rerere = {
          enabled = true;
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
      };
      history = {
        ignorePatterns = [ "exit" "rm *" ];
        ignoreSpace = true;
      };
      initExtra = ''
        autoload -z edit-command-line
        zle -N edit-command-line

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

        bindkey "^V^V" edit-command-line

        export PATH=$PATH:~/go/bin

        # Jump shell
        eval "$(${pkgs.jump}/bin/jump shell zsh)"
      '';
    };
  };
}
