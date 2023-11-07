return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/popup.nvim' },
    { 'BurntSushi/ripgrep' },
    { 'nvim-lua/plenary.nvim' },
  },
  cmd = 'Telescope',
  init = function()
    vim.keymap.set("n", "<space>", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-p>", "<cmd>Telescope git_files<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-_>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { noremap = true, silent = true }) -- C-/
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope lsp_incoming_calls<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { noremap = true, silent = true })
  end,
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-o>"] = function(p_bufnr)
              require("telescope.actions").send_selected_to_qflist(p_bufnr)
              vim.cmd.cfdo("edit")
            end,
          },
        },
      },
      pickers = {
        buffers = {
          show_all_buffers = true,
          mappings = {
            i = {
              ["<c-q>"] = "delete_buffer",
            }
          }
        }
      }
    }
  end,
}
