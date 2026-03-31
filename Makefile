.PHONY: switch
switch:
	darwin-rebuild switch --flake .

.PHONY: cache
cache:
	nix build \
    .#darwinConfigurations.Anttis-MBP.system \
    .#darwinConfigurations.akupila-M-CQ3LG7V9X3.system \
    --json \
  | jq -r '.[].outputs | to_entries[].value' \
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
