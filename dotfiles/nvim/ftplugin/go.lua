vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then
			return
		end

		local win = vim.api.nvim_get_current_win()
		local client = vim.lsp.get_clients({ bufnr = buf })[1]
		local params = vim.lsp.util.make_range_params(win, client.offset_encoding)
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = false
