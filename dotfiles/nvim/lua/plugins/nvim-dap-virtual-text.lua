return {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require("nvim-dap-virtual-text").setup {
      enabled_commands = false,

      highlight_changed_variables = false,
      highlight_new_as_changed = false,
      only_first_definition = false,
      all_references = true,
    }
  end
}
