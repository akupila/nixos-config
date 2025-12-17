vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  cmdline = {
    enabled = false,
  },
  signature = { enabled = true },
})
