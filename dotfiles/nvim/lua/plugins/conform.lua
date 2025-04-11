return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>tf",
			function()
				-- If autoformat is currently disabled for this buffer,
				-- then enable it, otherwise disable it
				if vim.b.disable_autoformat then
					vim.cmd("FormatEnable")
					vim.notify("Enabled autoformat for current buffer")
				else
					vim.cmd("FormatDisable!")
					vim.notify("Disabled autoformat for current buffer")
				end
			end,
			desc = "Toggle autoformat for current buffer",
		},
		{
			"<leader>tF",
			function()
				-- If autoformat is currently disabled globally,
				-- then enable it globally, otherwise disable it globally
				if vim.g.disable_autoformat then
					vim.cmd("FormatEnable")
					vim.notify("Enabled autoformat globally")
				else
					vim.cmd("FormatDisable")
					vim.notify("Disabled autoformat globally")
				end
			end,
			desc = "Toggle autoformat globally",
		},
	},
	opts = {
		notify_on_error = false,
		stop_after_first = true,
		formatters_by_ft = {
			sh = { "shfmt" },
			javascript = { "biome" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			sql = { "pg_format" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			lua = { "stylua" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			biome = {
				args = {
					"format",
					"--stdin-file-path",
					"$FILENAME",
					"--indent-style",
					"space",
					"--indent-size",
					"2",
					"--quote-style",
					"single",
					"--trailing-comma",
					"all",
					"--line-width",
					"90",
				},
			},
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- :FormatDisable! disables autoformat for this buffer only
				vim.b.disable_autoformat = true
			else
				-- :FormatDisable disables autoformat globally
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true, -- allows the ! variant
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
