{ pkgs, lib, ... }:

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
      _1password-cli
      cachix
      cargo
      coreutils
      fd
      gnupg
      go
      graphviz
      jq
      jump
      lua-language-server
      ncdu
      neovim
      nil
      nodejs
      podman
      pv
      ripgrep
      tree
      watch
      yamlfmt
      yubikey-manager
    ];

    stateVersion = "23.11";
  };

  xdg.configFile = {
    nvim = dotfiles "nvim";
    wezterm = dotfiles "wezterm";
    atuin = dotfiles "atuin";
    ghostty = dotfiles "ghostty";
    starship-jj = dotfiles "starship-jj";
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
      ignores = [ ".DS_Store" ".envrc" ".direnv" ".local*" "shell.nix" ];
      signing.key = null;
      attributes = [
        "go.sum merge=union"
        "go.work.sum merge=union"
      ];
      settings = {
        alias = {
          recent = "for-each-ref --sort=-committerdate --count=20 --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))' refs/heads";
          fixup = "!f() { git commit --fixup $1; GIT_SEQUENCE_EDITOR=true git rebase -i --autostash --autosquash $1^; }; f";
          wip = "commit -m 'wip [skip ci]'";
        };
        user = {
          email = "akupila@gmail.com";
          name = "Antti Kupila";
        };
        branch = {
          sort = "-committerdate";
        };
        color = {
          ui = "auto";
        };
        commit = {
          gpgSign = true;
          verbose = true;
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          renames = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
        };
        format = {
          pretty = "minimal";
        };
        gpg = {
          format = "ssh";
        };
        help = {
          autocorrect = 1;
        };
        init = {
          defaultBranch = "main";
        };
        maintenance = {
          auto = false;
          strategy = "incremental";
        };
        merge = {
          tool = "opendiff";
          conflictstyle = "zdiff3";
          keepbackup = false;
        };
        pretty = {
          minimal = "%C(auto)%h %d %C(bold)%s%C(reset) %C(dim)(%cn %cr)%C(reset)";
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
          autoupdate = true;
        };
        tag = {
          sort = "version:refname";
        };
        url = {
          "git@github.com:".insteadOf = "https://github.com";
        };
        user = {
          signingkey = "~/.ssh/id_ed25519.pub";
        };
      };
    };

    jujutsu = {
      enable = true;
      settings = {
        ui = {
          pager = ":builtin";
          default-command = "log";
        };
        user = {
          name = "Antti Kupila";
          email = "akupila@gmail.com";
        };
        signing = {
          behavior = "force";
          backend = "ssh";
          key = "~/.ssh/id_ed25519.pub";
        };
      };
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        follow_symlinks = false;
        scan_timeout = 10;
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$character"
        ];
        right_format = lib.concatStrings [
          "$cmd_duration"
          "\${custom.jj}"
          "$jobs"
          "$aws"
        ];
        directory = {
          style = "blue";
          truncate_to_repo = false;
        };
        character = {
          success_symbol = "[›](green)";
          error_symbol = "[›](red)";
        };
        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };
        jobs = {
          format = "[$number]($style) ";
          number_threshold = 1;
          style = "blue";
        };
        aws = {
          format = "[$profile]($style)";
          style = "cyan";
        };
        custom.jj = {
          command = "prompt";
          format = "$output";
          ignore_timeout = true;
          shell = [
            "starship-jj"
            "--ignore-working-copy"
            "starship"
          ];
          use_stdin = false;
          when = true;
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
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
        docker = "podman";
      };
      history = {
        ignorePatterns = [ "exit" "rm *" ];
        ignoreSpace = true;
      };
      initContent = ''
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

        export PATH=$PATH:~/.local/bin
        export PATH=$PATH:~/go/bin
        export PATH=$PATH:~/.cargo/bin
        export TMPDIR=/tmp

        eval "$(${pkgs.jump}/bin/jump shell zsh)"

        LOCAL_CONFIG="$HOME/.config/local.zsh"
        if [ -f "$LOCAL_CONFIG" ]; then
          source "$LOCAL_CONFIG"
        fi

        eval "$(starship init zsh)"
      '';
    };
  };
}
