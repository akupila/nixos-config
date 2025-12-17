vim.pack.add({ "https://github.com/Shatur/neovim-ayu" })

local ayu = require("ayu")

ayu.setup({
  overrides = {
    LineNr = { fg = "#404855" }, -- Slightly more visible
  },
})

ayu.colorscheme()
