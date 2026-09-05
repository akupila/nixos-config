-- Prevent using gofmt for formatting (provided by Neovim's native Go ftplugin)
vim.opt_local.formatprg = "" -- gq

-- Hard wrap comments with gq. gopls' range formatting leaves long lines alone,
-- and an empty 'formatexpr' just gets claimed by the LSP client again, so set it
-- to an expression that evaluates non-zero: Vim then falls back to its internal
-- formatter and the client leaves the option alone.
vim.opt_local.formatexpr = "1"

-- Remove '.' from iskeyword so viw selects 'Info' not 'slog.Info'
vim.opt_local.iskeyword:remove(".")
