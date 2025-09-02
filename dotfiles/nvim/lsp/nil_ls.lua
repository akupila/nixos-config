return {
	cmd = { "nil-ls" },
	filetypes = { "nix" },
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixpkgs-fmt" },
			},
		},
	},
}
