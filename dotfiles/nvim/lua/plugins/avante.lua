return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  opts = {
    -- add any opts here
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
}
