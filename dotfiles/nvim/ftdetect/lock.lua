vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "flake.lock",
	callback = function()
		vim.bo.filetype = "json"
	end,
})
