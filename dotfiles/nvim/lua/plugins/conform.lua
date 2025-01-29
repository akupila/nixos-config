return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    stop_after_first = true,
    formatters_by_ft = {
      sh = { "shfmt" },
      javascript = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      sql = { "pg_format" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
    format_on_save = {
      timeout_ms = 2500,
      lsp_format = "fallback",
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      biome = {
        args = {
          "format",
          "--stdin-file-path", "$FILENAME",
          "--indent-style", "space",
          "--indent-size", "2",
          "--quote-style", "single",
          "--trailing-comma", "all",
          "--line-width", "90",
        },
      },
    },
  },
}
