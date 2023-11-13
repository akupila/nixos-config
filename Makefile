.PHONY: personal
personal:
	darwin-rebuild build --flake .#Anttis-MBP

.PHONY: work
work:
	darwin-rebuild build --flake .#antti-stream

.PHONY: xps
xps:
	nix build build --flake .#akupila-xps
