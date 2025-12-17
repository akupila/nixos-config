vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
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
    yaml = { "yamlfmt" },
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
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.keymap.set("n", "<leader>tf", function()
  if vim.b.disable_autoformat then
    vim.cmd("FormatEnable")
    vim.notify("Enabled autoformat for current buffer")
  else
    vim.cmd("FormatDisable!")
    vim.notify("Disabled autoformat for current buffer")
  end
end, { desc = "Toggle autoformat for current buffer" })

vim.keymap.set("n", "<leader>tF", function()
  if vim.g.disable_autoformat then
    vim.cmd("FormatEnable")
    vim.notify("Enabled autoformat globally")
  else
    vim.cmd("FormatDisable")
    vim.notify("Disabled autoformat globally")
  end
end, { desc = "Toggle autoformat globally" })
