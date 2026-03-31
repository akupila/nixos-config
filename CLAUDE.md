# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

```bash
make switch   # Apply configuration (darwin-rebuild switch --flake .)
make update   # Update all flake inputs
make check    # Validate configuration (nix flake check --all-systems)
make cache    # Push flake to cachix
make gc       # Garbage collect builds older than 7 days
make clean    # Remove build artifacts
```

Enter the dev shell with `nix-shell` to get `nil` (Nix LSP), `nixpkgs-fmt`, and `lua-language-server`.

## Architecture

This is a **nix-darwin** configuration managing two macOS machines (personal and work) via Nix Flakes.

### Module hierarchy

`flake.nix` defines two `darwinConfigurations`, both following this layered module stack:

1. `modules/default.nix` — Core Nix settings: experimental features, cachix substituter, Zsh, home-manager integration
2. `modules/darwin.nix` — macOS-specific: fonts, Homebrew path, Touch ID for sudo, key repeat settings
3. `modules/home.nix` — User packages, programs (git, jj, neovim, fzf, direnv), and dotfile symlinks to `~/.config/`
4. `modules/personal.nix` or `modules/work.nix` — Machine-specific overrides (packages, git email, env vars)

### Dotfiles

`dotfiles/` contains application configs that are symlinked into `~/.config/` by home-manager (defined in `modules/home.nix`). Editing files here takes effect after `make switch`.

### Key inputs

| Input | Source |
|---|---|
| `nixpkgs` | `nixpkgs-unstable` |
| `darwin` | `LnL7/nix-darwin` |
| `home-manager` | `nix-community/home-manager` |
| `neovim-nightly-overlay` | `nix-community/neovim-nightly-overlay` |

### Machine configs

- **Personal** (`Anttis-MBP`): `default` + `darwin` + `personal` modules; `GOPRIVATE=github.com/akupila`
- **Work** (`akupila-M-CQ3LG7V9X3`): `default` + `darwin` + `work` modules; adds AWS/k8s/Terraform tooling, `GOPRIVATE=github.com/iceye-ltd`

### Version control

Both git and jujutsu (jj) are configured. SSH signing is enabled on both.

## Making changes

Each change must be a new jujutsu change with a Go-style commit message:

```
<scope>: <change>
```

Examples: `home: add ripgrep`, `work: update kubectl version`, `nvim: enable treesitter for go`

Create a new change before editing:

```bash
jj new -m "<scope>: <change>"
```

Or describe the current change after editing:

```bash
jj describe -m "<scope>: <change>"
```
