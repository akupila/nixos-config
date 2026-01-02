-- Prevent using gofmt for formatting (provided by Neovim's native Go ftplugin)
vim.opt_local.formatprg = "" -- gq
vim.opt_local.formatexpr = "" -- LSP range formatting

-- Remove '.' from iskeyword so viw selects 'Info' not 'slog.Info'
vim.opt_local.iskeyword:remove(".")
