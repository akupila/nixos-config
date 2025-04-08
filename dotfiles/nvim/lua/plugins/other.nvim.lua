return {
  'rgroli/other.nvim',
  config = function()
    require("other-nvim").setup({
      mappings = {
        -- Go
        {
          context = "implementation",
          pattern = "(.*)_test.go$",
          target = "%1.go",
        },
        {
          context = "test",
          pattern = "(.*[^_test]).go$",
          target = "%1_test.go",
        },
      },
      style = {
        border = "rounded",
      },
    })

    vim.api.nvim_set_keymap("n", "<space>", "<cmd>:Other<CR>", { desc = "Open alternate file" })
  end,
}
