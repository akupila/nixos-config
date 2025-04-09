return {
  "ibhagwan/fzf-lua",
  opts = {},
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      winopts = {
        width = 0.9,
        height = 0.9,
        preview = {
          horizontal = "right:50%",
          vertical = "down:65%",
          title = false,
        },
      },
      grep = {
        winopts = { preview = { hidden = true } }
      },
    })

    vim.keymap.set("n", "<C-\\>", fzf.buffers, { desc = "Fuzzy find buffers" })
    vim.keymap.set("n", "<C-k>", fzf.builtin, { desc = "Fuzzy find builtin" })
    vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Fuzzy find files" })
    vim.keymap.set("n", "<C-l>", fzf.live_grep_glob, { desc = "Fuzzy find live grep" })
    vim.keymap.set("n", "<C-g>", fzf.grep_project, { desc = "Fuzzy find grep project" })
  end
}
