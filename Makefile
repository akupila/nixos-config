UNAME := $(shell uname)

.PHONY: switch
switch:
	darwin-rebuild switch --flake .

.PHONY: cache
cache:
	nix flake archive --json \
  | jq -r '.path,(.inputs|to_entries[].value.path)' \
  | cachix push akupila-nixos-config

.PHONY: clean
clean:
	rm -rf result

.PHONY: update
update:
	nix flake update

.PHONY: check
check:
	@nix flake check --all-systems && echo "OK"

.PHONY: gc
gc:
	nix-collect-garbage --delete-older-than 7d
