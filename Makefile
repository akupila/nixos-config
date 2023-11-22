.PHONY: switch
switch:
	darwin-rebuild switch --flake .

.PHONY: clean
clean:
	rm -rf output

.PHONY: update
update:
	nix flake update

.PHONY: check
check:
	@nix flake check --all-systems && echo "OK"
