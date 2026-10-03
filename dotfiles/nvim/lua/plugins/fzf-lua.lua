vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

-- Search hidden and gitignored files; exclude junk dirs instead.
local exclude = table.concat({
  "--exclude .git",
  "--exclude .jj",
  "--exclude node_modules",
  "--exclude .direnv",
  "--exclude .venv",
  "--exclude venv",
  "--exclude __pycache__",
}, " ")

fzf.setup({
  winopts = {
    -- Neovim nightly: nvim_open_win0 may return nil (nvim_win_call), then
    -- utils.wo[nil] crashes in __index. Disabling backdrop skips that path.
    backdrop = false,
    width = 0.9,
    height = 0.9,
    preview = {
      horizontal = "right:50%",
      vertical = "down:65%",
      title = false,
    },
  },
  files = {
    hidden = true,
    no_ignore = true,
    toggle_ignore_flag = "--no-ignore-vcs",
    fd_opts = "--color=never --type f --type l " .. exclude,
  },
  grep = {
    hidden = true,
    no_ignore = true,
    toggle_ignore_flag = "--no-ignore-vcs",
    winopts = { preview = { layout = "vertical" } },
  },
})

vim.keymap.set("n", "<C-\\>", fzf.buffers, { desc = "Fuzzy find buffers" })
vim.keymap.set("n", "<C-k>", fzf.builtin, { desc = "Fuzzy find builtin" })
vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Fuzzy find files" })
vim.keymap.set("n", "<C-g>", fzf.grep_project, { desc = "Fuzzy find grep project" })
