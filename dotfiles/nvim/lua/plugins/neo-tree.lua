return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>")
    vim.keymap.set("n", "<leader><C-n>", "<cmd>Neotree reveal<cr>")
  end,
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          never_show = {
            ".DS_Store",
          },
        },
        renderers = {
          directory = {
            { "icon" },
            {
              "name",
              use_git_status_colors = true,
              trailing_slash = true
            },
            { "diagnostics" },
            { "git_status" },
          },
        },
        window = {
          mappings = {
            ["<F5>"] = "refresh",
            ["o"] = "open",
            ['/'] = "noop", -- Use built-in search instead
          },
        },
      },
      default_component_configs = {
        container = {
          enable_character_fade = false,
        },
        indent = {
          padding = 0,
          with_markers = false,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    })
  end,
}
