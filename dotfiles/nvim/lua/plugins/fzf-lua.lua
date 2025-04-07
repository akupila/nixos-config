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

    vim.api.nvim_set_keymap("n", "<C-\\>", [[<Cmd>lua require"fzf-lua".buffers()<CR>]], { desc = "Fuzzy find buffers" })
    vim.api.nvim_set_keymap("n", "<C-k>", [[<Cmd>lua require"fzf-lua".builtin()<CR>]], { desc = "Fuzzy find builtin" })
    vim.api.nvim_set_keymap("n", "<C-p>", [[<Cmd>lua require"fzf-lua".files()<CR>]], { desc = "Fuzzy find files" })
    vim.api.nvim_set_keymap("n", "<C-l>", [[<Cmd>lua require"fzf-lua".live_grep_glob()<CR>]], { desc = "Fuzzy find live grep" })
    vim.api.nvim_set_keymap("n", "<C-g>", [[<Cmd>lua require"fzf-lua".grep_project()<CR>]], { desc = "Fuzzy find grep project" })
  end
}
