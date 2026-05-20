vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

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
  grep = {
    winopts = { preview = { layout = "vertical" } },
  },
})

vim.keymap.set("n", "<C-\\>", fzf.buffers, { desc = "Fuzzy find buffers" })
vim.keymap.set("n", "<C-k>", fzf.builtin, { desc = "Fuzzy find builtin" })
vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Fuzzy find files" })
vim.keymap.set("n", "<C-l>", fzf.live_grep_glob, { desc = "Fuzzy find live grep" })
vim.keymap.set("n", "<C-g>", fzf.grep_project, { desc = "Fuzzy find grep project" })
