UNAME := $(shell uname)

.PHONY: switch
switch:
	darwin-rebuild switch --flake .

.PHONY: update
update:
	nix flake update

.PHONY: check
check:
	@nix flake check --all-systems && echo "OK"

.PHONY: gc
gc:
	nix-collect-garbage --delete-older-than 7d
