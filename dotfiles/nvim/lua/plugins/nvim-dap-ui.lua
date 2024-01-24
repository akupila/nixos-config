return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local dap = require('dap')
    local dapui = require("dapui")

    dapui.setup()

    vim.keymap.set('n', '<F8>', dapui.toggle)

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end
}
