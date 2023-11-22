typeset -U path cdpath fpath manpath

# for profile in ${(z)NIX_PROFILES}; do
#   fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
# done

P10K_INSTANT_PROMPT="$HOME/.cache/p10k-instant-prompt-$USER.zsh"
[[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

path+="$HOME/.config/zsh/plugins/powerlevel10k"
fpath+="$HOME/.config/zsh/plugins/powerlevel10k"
path+="$HOME/.config/zsh/plugins/powerlevel10k-config"
fpath+="$HOME/.config/zsh/plugins/powerlevel10k-config"
path+="$HOME/.config/zsh/plugins/gocover"
fpath+="$HOME/.config/zsh/plugins/gocover"

# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit

if [[ -f "$HOME/.config/zsh/plugins/powerlevel10k/share/zsh-powerlevel10k/powerlevel10k.zsh-theme" ]]; then
	source "$HOME/.config/zsh/plugins/powerlevel10k/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
fi
if [[ -f "$HOME/.config/zsh/plugins/powerlevel10k-config/p10k.zsh" ]]; then
	source "$HOME/.config/zsh/plugins/powerlevel10k-config/p10k.zsh"
fi
if [[ -f "$HOME/.config/zsh/plugins/gocover/gocover.zsh" ]]; then
	source "$HOME/.config/zsh/plugins/gocover/gocover.zsh"
fi

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"
HISTORY_IGNORE='(exit|rm *)'
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

if [[ $options[zle] = on ]]; then
	. /nix/store/bh28qf7yz21z9y38lbv2vdsgpnli8zx6-fzf-0.42.0/share/fzf/completion.zsh
	. /nix/store/bh28qf7yz21z9y38lbv2vdsgpnli8zx6-fzf-0.42.0/share/fzf/key-bindings.zsh
fi

eval "$(/nix/store/pkj1ki51sylbb4dylbc3ac2y4vv9xczv-direnv-2.32.3/bin/direnv hook zsh)"

# jump shell
eval $(/nix/store/vkca4dfpl57125s8nhsigmcg0plp53yi-jump-0.51.0/bin/jump shell zsh)

# Do not exit on ctrl-d
setopt ignore_eof

# Keys
bindkey '^[[3~' delete-char     # Delete
bindkey '^[[C' forward-char     # Right
bindkey '^[[D' backward-char    # Left
bindkey '^[[1;5D' backward-word # Ctrl-Left
bindkey '^[[1;5C' forward-word  # Ctrl-Right
bindkey '^H' backward-kill-word # Ctrl-H deletes word
bindkey '^[[Z' undo             # Shift-Tab

# Aliases
alias .='pwd'
alias ..='cd ..'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias gp='git log --stat --max-count=1 --format=medium'
alias gs='git status'
alias l='ls -alh'
alias nixrebuild='darwin-rebuild switch --flake ~/nixos-config/.#'
alias nixupdate='pushd ~/nixos-config; nix flake update; nixrebuild; popd'

# Named Directory Hashes
