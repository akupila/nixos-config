vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.mdc",
	callback = function()
		vim.bo.filetype = "markdown"
	end,
})
