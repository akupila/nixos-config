return {
	"Shatur/neovim-ayu",
	config = function()
		local ayu = require("ayu")

		ayu.setup({
			overrides = {
				LineNr = { fg = "#404855" }, -- Slightly more visible
			},
		})

		ayu.colorscheme()
	end,
}
