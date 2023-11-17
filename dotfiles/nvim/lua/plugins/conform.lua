return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      sh = { { "shfmt" } },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
    },
    format_on_save = {
      timeout_ms = 2500,
      lsp_fallback = true,
    },
    log_level = vim.log.levels.DEBUG,
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
}
