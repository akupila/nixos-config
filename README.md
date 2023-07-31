# NixOS Config

This is my personal dev setup, managed by [NixOS]. This exists primarily as a
backup and so i can sync things myself between laptops; don't blindly take this
and apply it to your system. You've been warned 😇

## Trying it out in a virtual machine

On a MacOS host machine, an easy way to do this is with [UTM]. Note that while
we don't need much space, MacOS will refuse to install if you don't give it a
big enough HD. 32gb worked for me. Let it download MacOS from Apple and follow
the regular process of setting up the machine. I used a user called `Demo` with
an account name `demo` here, so i ended up with a machine called
`Demos-Virtual-Machine`.

Now open the terminal and [install nix]:

```zsh
Last login: Thu Aug 3 10:47:39 on console
demo@Demos-Virtual-Machine ~ % sh <(curl -L https://nixos.org/nix/install) --daemon
```

Restart the terminal to enable nix.

We need to clone the git repo, but we don't have git installed. Instead of
installing git on the system, we can use `nix-shell -p git` to get a temporary
shell with git installed.

```zsh
demo@Demos-Virtual-Machine ~ % nix-shell -p git
[nix-shell:~]$ # Yay, we now have git available
[nix-shell:~]$ git --version
git version 2.41.0
```

Clone this repo:

```zsh
[nix-shell:~]$ git clone https://github.com/akupila/nixos-config.git
[nix-shell:~]$ cd nixos-config
```

_We don't **need** the nix shell anymore, so we could also `exit` out._

**Optional:** Some GUI apps are installed using [Homebrew], so they end up
`/Applications`. This is optional - if homebrew is not installed, these apps
are just not installed. Here, we'll install Homebrew first so we get the full
setup:

```zsh
[nix-shell:~/nixos-config]$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

The config has the name of the machine, which won't match the VM. Replace
`Anttis-MBP` with `Demos-Virtual-Machine` in `~/nixos-config/flake.nix` and
`akupila` with `demo` in `flake.nix` and `configuration.nix`. Now we can
bootstrap the new system:

```
[nix-shell:~/nixos-config]$ nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake .
```

This will download _a lot_ of stuff, install it and configure the system
according to the configuration in this repo. It'll take a while but it's mostly
hands-off, except for entering the sudo password once.

We're done! 🎉

We can now open [WezTerm], which provides some nice features and true color
support. We now also have `git` so we don't need to do the `nix-shell` trick
anymore. We can now start [Neovim] with `nvim`, which will install its own
plugins.

For updates, we can modify the files in `~/nixos-config` and apply the changes:

```zsh
$ darwin-rebuild switch --flake ~/nixos-config
```

If files are added or renamed, they need to be added the git staging are first
(no need to commit): `git add .`.



[NixOS]: https://nixos.org
[UTM]: https://mac.getutm.app
[install nix]: https://nixos.org/download.html
[Homebrew]: https://brew.sh
[WezTerm]: https://wezfurlong.org/wezterm/index.html
[Neovim]: https://neovim.io
