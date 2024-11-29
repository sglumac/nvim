return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap.automatic_setup")(config)
          end,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      -- Set up LLDB Debug Adapter
      dap.adapters.lldb = {
        type = 'executable',
        command = 'lldb-vscode',  -- Make sure lldb-vscode is installed and this points to the correct path
        name = 'lldb',
      }

      -- Debug Configuration for C++ and C files
      dap.configurations.cpp = {
        {
          name = 'Launch C++ Program',
          type = 'lldb',           -- Matches the adapter name defined above
          request = 'launch',      -- Launch mode
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',  -- Current directory where the program will run
          stopOnEntry = false,         -- Whether to stop at the entry point of the program
          args = {},                   -- Command-line arguments to the program
          runInTerminal = false,
        },
      }

      -- Reuse the same configuration for C files
      dap.configurations.c = dap.configurations.cpp
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
