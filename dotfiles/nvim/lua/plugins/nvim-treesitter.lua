return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		ensure_installed = {
			"bash",
			"go",
			"gomod",
			"gosum",
			"html",
			"json",
			"git_config",
			"git_rebase",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"yaml",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
