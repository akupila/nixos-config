vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
vim.pack.add({ "https://github.com/williamboman/mason-lspconfig.nvim" })

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"lua_ls",
		"nil_ls",
	},
})
