return {
  'ThePrimeagen/harpoon',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { "<leader>hm",    "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
    { "<leader>hn",    "<cmd>lua require('harpoon.ui').nav_next()<cr>",   desc = "Go to next harpoon mark" },
    { "<leader>hp",    "<cmd>lua require('harpoon.ui').nav_prev()<cr>",   desc = "Go to previous harpoon mark" },
    { "<C-h>", "<cmd>Telescope harpoon marks<cr>",                        desc = "Show harpoon marks" },
  },
  setup = function()
    require("telescope").load_extension('harpoon')
  end,
}
