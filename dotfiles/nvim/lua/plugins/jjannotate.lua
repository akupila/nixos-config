vim.pack.add({ "https://tangled.org/ronshavit.com/jjannotate.nvim" })

vim.g.jjannotate_opts = {
	view = {
		collapse_repeating_lines = false,
		highlight_changed_lines = false,
	},
}

local jjannotate = require("jjannotate")
vim.keymap.set("n", "<leader>ja", jjannotate.toggle)
