OS = $(shell uname -s)

.PHONY: switch
switch:
ifeq ($(OS),Darwin)
	darwin-rebuild switch --flake .
else ifeq ($(OS),Linux)
	sudo nixos-rebuild switch --flake .
endif

.PHONY: clean
clean:
	rm -rf output

.PHONY: update
update:
	nix flake update

.PHONY: check
check:
	@nix flake check --all-systems && echo "OK"
