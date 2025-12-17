vim.pack.add({ "https://github.com/rcarriga/nvim-notify" })

local notify = require("notify")

notify.setup({
  render = "minimal",
  stages = "static",
})

vim.notify = notify
