-- Treesitter parsers are installed via Nix (see home.nix)
-- This just ensures highlighting is enabled for all filetypes

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
