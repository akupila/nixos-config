return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      sh = { { "shfmt" } },
      javascript = { { "biome" } },
      typescript = { { "biome" } },
    },
    format_on_save = {
      timeout_ms = 2500,
      lsp_fallback = true,
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
