return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    notify.setup({
      render = "minimal",
      stages = "static",
    })
    vim.notify = notify
  end,
};
